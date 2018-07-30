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

        // Window Setting
        setWindow()

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

    private func setWindow() {
        // ページを格納する配列
        var viewControllers: [UIViewController] = []

        // 1ページ目になるViewController
        let firstVC = SearchViewController() as UIViewController
        firstVC.tabBarItem = UITabBarItem(tabBarSystemItem: .search, tag: 1)
        viewControllers.append(firstVC)

        // 2ページ目になるViewController
        let secondVC = MyPageViewController() as UIViewController
        secondVC.tabBarItem = UITabBarItem(tabBarSystemItem: .favorites, tag: 2)
        viewControllers.append(secondVC)

        // 3ページ目になるViewController
        let thirdVC = SearchViewController() as UIViewController
        thirdVC.tabBarItem = UITabBarItem(tabBarSystemItem: .contacts, tag: 3)
        viewControllers.append(thirdVC)

        // ViewControllerをセット
        let tabBarController = UITabBarController()
        tabBarController.setViewControllers(viewControllers, animated: false)

        // rootViewControllerをUITabBarControllerにする
        window = UIWindow()
        window?.rootViewController = tabBarController
        window?.backgroundColor = UIColor.white
        window?.makeKeyAndVisible()
    }
}
