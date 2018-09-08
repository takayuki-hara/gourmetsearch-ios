//
//  AppDelegate.swift
//  gourmetsearch
//
//  Created by 原隆幸 on 2018/07/29.
//  Copyright © 2018年 Penguin. All rights reserved.
//

import UIKit
import UserNotifications
import Firebase
import FirebaseMessaging

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // SwiftyBeaverの初期化
        SwiftyBeaverUtil.initialize()
        log.info("LogFile:" + SwiftyBeaverUtil.logfilePath())

        // Firebase
        FirebaseConfiguration.shared.setLoggerLevel(.info)
        FirebaseApp.configure()
        Messaging.messaging().delegate = self
        NotificationInitializer.setting()

        // UserDefaults
        UserDefaultsUtil.debugPrintAllUserDefaults()
        UserDefaultsUtil.incrementLaunchCount()

        // Window Setting
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = MainTabBarController()
        window?.backgroundColor = UIColor.white
        window?.makeKeyAndVisible()

        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
    }

    func applicationWillTerminate(_ application: UIApplication) {
    }

}

extension AppDelegate: UNUserNotificationCenterDelegate {
    // MARK: - UNUserNotificationCenterDelegate

    // フォアグラウンドでプッシュ通知を受け取った際の処理
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Swift.Void) {
        log.info("get notification")
        completionHandler([.alert, .sound])
    }

}

extension AppDelegate: MessagingDelegate {
    // MARK: - MessagingDelegate

    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String) {
        print("Firebase registration token: \(fcmToken)")

        // TODO: If necessary send token to application server.
        // Note: This callback is fired at each app startup and whenever a new token is generated.
    }
}
