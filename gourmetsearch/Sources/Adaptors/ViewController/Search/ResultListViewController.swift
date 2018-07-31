//
//  ResultListViewController.swift
//  gourmetsearch
//
//  Created by 原隆幸 on 2018/07/31.
//  Copyright © 2018年 Penguin. All rights reserved.
//

import UIKit
import XLPagerTabStrip

class ResultListViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // for debug
        let label = UILabel()
        label.text = "ResultListViewController"
        view.addSubview(label)
        label.snp.makeConstraints { make in
            make.center.equalTo(view)
        }
        view.backgroundColor = UIColor.yellow
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

extension ResultListViewController: IndicatorInfoProvider {
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: "List")
    }
}
