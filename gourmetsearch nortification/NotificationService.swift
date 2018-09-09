//
//  NotificationService.swift
//  gourmetsearch nortification
//
//  Created by 原隆幸 on 2018/09/08.
//  Copyright © 2018年 Penguin. All rights reserved.
//

import CoreGraphics
import UserNotifications
import Alamofire

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

        // 画像が含まれていない場合はそのまま返す
        guard let mediaUrlString = request.content.userInfo["image_url"] as? String else {
            contentHandler(request.content)
            return
        }

        // URLが正しくない、あるいはローカルファイルの場合(i.e., file://movie.mp4)
        guard let mediaUrl = URL(string: mediaUrlString), !mediaUrl.isFileURL else {
            self.modifyContentAltText()
            contentHandler(modifiedNotificationContent!)
            return
        }

        // メディアをダウンロード
        var useAlternateText: Bool = true
        if let location = fetchMediaFile(url: mediaUrl) {
            let localMediaUrl = URL.init(fileURLWithPath: location.path + mediaUrl.lastPathComponent)
            try? FileManager.default.removeItem(at: localMediaUrl)
            if (try? FileManager.default.moveItem(at: location, to: localMediaUrl)) != nil {
                let mediaAttachment: UNNotificationAttachment? = self.createMediaAttachment(localMediaUrl)
                if mediaAttachment != nil {
                    self.modifiedNotificationContent?.attachments = [mediaAttachment!]
                    useAlternateText = false
                }
            }
        }

        // メディアが取得できなかったので代替テキストを設定する
        if (useAlternateText == true) {
            self.modifyContentAltText()
        }

        self.contentHandler?((self.modifiedNotificationContent)!)
    }

    private func fetchMediaFile(url: URL) -> URL? {
        // 非同期にした場合にダウンロードしたファイルが読めなかったので同期処理にする（呼び出し元自体がメインスレッドではない）
        let semaphore = DispatchSemaphore(value: 0)
        let queue = DispatchQueue.global(qos: .utility)
        var location: URL? = nil
        Alamofire.download(url).response(queue: queue) { response in
            location = response.temporaryURL
            semaphore.signal()
        }
        semaphore.wait()
        return location
    }

    override func serviceExtensionTimeWillExpire() {
        // Extensionの処理は時間的な制約があり打ち切られる前にここが呼ばれる
        modifyContentAltText()
        contentHandler?(modifiedNotificationContent!)
    }

    private func modifyContentAltText() {
        guard let mediaAltText = modifiedNotificationContent?.userInfo["image_alt"] as? String else { return }
        if !mediaAltText.isEmpty {
            modifiedNotificationContent?.body = mediaAltText
        }
    }
}
