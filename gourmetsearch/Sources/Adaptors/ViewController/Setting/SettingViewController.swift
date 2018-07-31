//
//  SettingViewController.swift
//  gourmetsearch
//
//  Created by 原隆幸 on 2018/07/30.
//  Copyright © 2018年 Penguin. All rights reserved.
//

import UIKit
import SnapKit

class SettingViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // for debug
        let label = UILabel()
        label.text = "SettingViewController"
        view.addSubview(label)
        label.snp.makeConstraints { make in
            make.center.equalTo(view)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
