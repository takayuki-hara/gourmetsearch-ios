//
//  MyPageViewController.swift
//  gourmetsearch
//
//  Created by 原隆幸 on 2018/07/30.
//  Copyright © 2018年 Penguin. All rights reserved.
//

import UIKit
import SnapKit
import XLPagerTabStrip

class MyPageViewController: SegmentedPagerTabStripViewController {

    // MARK: - Properties
    let scroll = UIScrollView()
    let segmented = UISegmentedControl()

    // MARK: - Lifecycle Methods
    override func viewDidLoad() {
        beforeViewDidLoad()
        super.viewDidLoad()

        view.setNeedsUpdateConstraints()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func updateViewConstraints() {
        setupConstraints()
        super.updateViewConstraints()
    }

    // MARK: - Public Methods
    override func viewControllers(for pagerTabStripController: PagerTabStripViewController) -> [UIViewController] {
        let firstVC = HistoryViewController()
        let secondVC = FavoriteViewController()
        let childViewControllers: [UIViewController] = [firstVC, secondVC]
        return childViewControllers
    }

    // MARK: - Private Methods
    private func beforeViewDidLoad() {
        // XLPagerTabStrip を使用するためにviewDidLoad()の前に行う処理
        view.addSubview(segmented)
        containerView = scroll
        segmentedControl = segmented
    }

    private func setupConstraints() {
        segmentedControl.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.centerX.equalToSuperview()
            make.size.equalTo(CGSize(width: 300, height: 30))
        }
        scroll.snp.makeConstraints { make in
            make.top.equalTo(segmented.snp.bottom).offset(4)
            make.centerX.equalToSuperview()
            make.width.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        }
    }

}
