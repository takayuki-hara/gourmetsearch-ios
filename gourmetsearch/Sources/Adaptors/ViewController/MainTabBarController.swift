//
//  MainTabBarController.swift
//  gourmetsearch
//
//  Created by 原隆幸 on 2018/07/31.
//  Copyright © 2018年 Penguin. All rights reserved.
//

import UIKit

class MainTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let firstVC = SearchViewController() as UIViewController
        firstVC.tabBarItem = UITabBarItem(tabBarSystemItem: .search, tag: 1)
        let firstNaviCon = UINavigationController(rootViewController: firstVC)

        let secondVC = MyPageViewController() as UIViewController
        secondVC.tabBarItem = UITabBarItem(tabBarSystemItem: .favorites, tag: 2)
        let secondNaviCon = UINavigationController(rootViewController: secondVC)

        let thirdVC = SettingViewController() as UIViewController
        thirdVC.tabBarItem = UITabBarItem(tabBarSystemItem: .more, tag: 3)
        let thirdNaviCon = UINavigationController(rootViewController: thirdVC)

        setViewControllers([firstNaviCon, secondNaviCon, thirdNaviCon], animated: false)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
