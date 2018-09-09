//
//  NotificationService.swift
//  gourmetsearch nortification
//
//  Created by 原隆幸 on 2018/09/08.
//  Copyright © 2018年 Penguin. All rights reserved.
//

import CoreGraphics
import UserNotifications

class NotificationService: UNNotificationServiceExtension {
    var contentHandler: ((_ contentToDeliver: UNNotificationContent) -> Void)? = nil
    var modifiedNotificationContent: UNMutableNotificationContent?

    func createMediaAttachment(_ localMediaUrl: URL) -> UNNotificationAttachment {
        let clippingRect = CGRect.zero
        let mediaAttachment = try? UNNotificationAttachment(identifier: "attachmentIdentifier", url: localMediaUrl, options: [UNNotificationAttachmentOptionsThumbnailClippingRectKey: clippingRect.dictionaryRepresentation, UNNotificationAttachmentOptionsThumbnailHiddenKey: false])
        return mediaAttachment!
    }

    override func didReceive(_ request: UNNotificationRequest, withContentHandler contentHandler: @escaping (UNNotificationContent) -> Void) {
        self.contentHandler = contentHandler
        modifiedNotificationContent = (request.content.mutableCopy() as? UNMutableNotificationContent)

        guard let mediaUrlString = request.content.userInfo["image_url"] as? String else {
            contentHandler(request.content)
            return
        }

        // see if the media URL is for a local file  (i.e., file://movie.mp4)
        guard let mediaUrl = URL(string: mediaUrlString), !mediaUrl.isFileURL else {
            modifyContentWithLocalFile(mediaUrlString: mediaUrlString)
            contentHandler(modifiedNotificationContent!)
            return
        }

        // if we have a URL, try to download media (i.e., https://media.giphy.com/media/3oz8xJBbCpzG9byZmU/giphy.gif)
        // create a session to handle downloading of the URL
        let session = URLSession(configuration: URLSessionConfiguration.default)

        // start a download task to handle the download of the media
        weak var weakSelf: NotificationService? = self
        session.downloadTask(with: mediaUrl, completionHandler: {(_ location: URL?, _ response: URLResponse?, _ error: Error?) -> Void in
            var useAlternateText: Bool = true
            // if the download succeeded, save it locally and then make an attachment
            if error == nil {
                let downloadResponse = response as! HTTPURLResponse
                if (downloadResponse.statusCode >= 200 && downloadResponse.statusCode <= 299) {
                    // download was successful, attempt save the media file
                    let localMediaUrl = URL.init(fileURLWithPath: location!.path + mediaUrl.lastPathComponent)

                    // remove any existing file with the same name
                    try? FileManager.default.removeItem(at: localMediaUrl)

                    // move the downloaded file from the temporary location to a new file
                    if ((try? FileManager.default.moveItem(at: location!, to: localMediaUrl)) != nil) {
                        // create an attachment with the new file
                        let mediaAttachment: UNNotificationAttachment? = weakSelf?.createMediaAttachment(localMediaUrl)

                        // if no problems creating the attachment, we can use it
                        if mediaAttachment != nil {
                            // set the media to display in the notification
                            weakSelf?.modifiedNotificationContent?.attachments = [mediaAttachment!]

                            // everything is ok
                            useAlternateText = false
                        }
                    }
                }
            }

            if (useAlternateText == true) {
                self.modifyContentAltText()
            }
            weakSelf?.contentHandler?((weakSelf?.modifiedNotificationContent)!)
        }).resume()
    }

    override func serviceExtensionTimeWillExpire() {
        // Extensionの処理は時間的な制約があり打ち切られる前にここが呼ばれる
        modifyContentAltText()
        contentHandler?(modifiedNotificationContent!)
    }

    private func modifyContentWithLocalFile(mediaUrlString: String) {
        // attempt to create a URL to a file in local storage
        var useAlternateText: Bool = true
        if !mediaUrlString.isEmpty {
            let mediaUrlFilename:NSString = mediaUrlString as NSString
            let fileName = (mediaUrlFilename.lastPathComponent as NSString).deletingPathExtension
            let fileExtension = (mediaUrlFilename.lastPathComponent as NSString).pathExtension

            // is it in the bundle?
            if let localMediaUrlPath = Bundle.main.path(forResource: fileName, ofType: fileExtension) {
                // is the URL a local file URL?
                let localMediaUrl = URL.init(fileURLWithPath: localMediaUrlPath)
                if localMediaUrl.isFileURL {
                    // create an attachment with the local media
                    let mediaAttachment: UNNotificationAttachment? = createMediaAttachment(localMediaUrl)

                    // if no problems creating the attachment, we can use it
                    if mediaAttachment != nil {
                        // set the media to display in the notification
                        modifiedNotificationContent?.attachments = [mediaAttachment!]

                        // everything is ok
                        useAlternateText = false
                    }
                }
            }
        }

        if (useAlternateText == true) {
            modifyContentAltText()
        }
    }

    private func modifyContentAltText() {
        guard let mediaAltText = modifiedNotificationContent?.userInfo["image_alt"] as? String else { return }
        if !mediaAltText.isEmpty {
            modifiedNotificationContent?.body = mediaAltText
        }
    }
}
