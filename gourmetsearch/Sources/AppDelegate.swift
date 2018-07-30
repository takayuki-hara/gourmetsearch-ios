//
//  AppDelegate.swift
//  gourmetsearch
//
//  Created by 原隆幸 on 2018/07/29.
//  Copyright © 2018年 Penguin. All rights reserved.
//

import UIKit
import Firebase

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

        // UserDefaults
        UserDefaultsUtil.debugPrintAllUserDefaults()
        UserDefaultsUtil.incrementLaunchCount()

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
