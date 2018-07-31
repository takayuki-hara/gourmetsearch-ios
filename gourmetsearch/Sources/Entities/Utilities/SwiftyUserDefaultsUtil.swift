//
//  SwiftyUserDefaultsUtil.swift
//  gourmetsearch
//
//  Created by 原隆幸 on 2018/07/30.
//  Copyright © 2018年 Penguin. All rights reserved.
//

import Foundation
import SwiftyUserDefaults

extension DefaultsKeys {
    static let launchCount = DefaultsKey<Int>("launchCount")
}

class UserDefaultsUtil {

    class func incrementLaunchCount() {
        Defaults[.launchCount] += 1
    }

    class func debugPrintAllUserDefaults() {
        print("---------------------------------  UserDefaults  ---------------------------------")
        print("launchCount     = " + String(Defaults[.launchCount]))
        print("---------------------------------  UserDefaults  ---------------------------------")
    }

}
