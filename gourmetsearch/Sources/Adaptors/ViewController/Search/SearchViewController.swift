//
//  SearchViewController.swift
//  gourmetsearch
//
//  Created by 原隆幸 on 2018/07/30.
//  Copyright © 2018年 Penguin. All rights reserved.
//

import UIKit
import SnapKit

class SearchViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // for debug
        let label = UILabel()
        label.text = "SearchViewController"
        view.addSubview(label)
        label.snp.makeConstraints { make in
            make.center.equalTo(view)
        }
        let button = UIButton()
        button.setTitle("to Result", for: .normal)
        button.setTitleColor(.blue, for: .normal)
        button.addTarget(self, action: #selector(self.onClick(_:)), for: .touchUpInside)
        view.addSubview(button)
        button.snp.makeConstraints { make in
            make.centerX.equalTo(view)
            make.centerY.equalTo(view).offset(50)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // for debug
    @objc private func onClick(_ sender: AnyObject) {
        let next = ResultViewController()
        navigationController?.pushViewController(next, animated: true)
    }

}
