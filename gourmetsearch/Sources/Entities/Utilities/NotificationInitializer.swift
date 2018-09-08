//
//  NotificationInitializer.swift
//  gourmetsearch
//
//  Created by 原隆幸 on 2018/09/08.
//  Copyright © 2018年 Penguin. All rights reserved.
//

import UIKit
import UserNotifications

class NotificationInitializer {

    class func setting() {
        if #available (iOS 10.0, *) {
            guard let app: AppDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
            let center = UNUserNotificationCenter.current()
            center.delegate = app
            center.requestAuthorization(options: [.sound, .alert, .badge]) { (granted, _) in
                guard granted else { return }
                DispatchQueue.main.async {
                    UIApplication.shared.registerForRemoteNotifications()
                }
            }
        } else {
            if UIApplication.shared.responds(to: #selector(UIApplication.registerUserNotificationSettings(_:))) {
                let settings: UIUserNotificationSettings = UIUserNotificationSettings(types: [.alert, .badge, .sound], categories: nil)
                UIApplication.shared.registerUserNotificationSettings(settings)
                UIApplication.shared.registerForRemoteNotifications()
            }
        }
    }

}
