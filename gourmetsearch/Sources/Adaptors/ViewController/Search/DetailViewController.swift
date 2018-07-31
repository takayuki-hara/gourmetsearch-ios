//
//  DetailViewController.swift
//  gourmetsearch
//
//  Created by 原隆幸 on 2018/07/31.
//  Copyright © 2018年 Penguin. All rights reserved.
//

import UIKit
import WebKit
import SnapKit

class DetailViewController: UIViewController {

    // MARK: - Properties
    let webView = WKWebView()

    // MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()

        // for debug
        let urlRequest = URLRequest(url: URL(string: Consts.sampleUrl)!)
        webView.load(urlRequest)
        view.addSubview(webView)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func updateViewConstraints() {
        setupConstraints()
        super.updateViewConstraints()
    }

    // MARK: - Private Methods
    private func setupConstraints() {
        webView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.width.equalToSuperview()
            make.centerX.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        }
    }
}

extension DetailViewController: WKNavigationDelegate {
    // MARK: - WKNavigationDelegate
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        // TODO:
    }
}

extension DetailViewController: WKUIDelegate {
    // MARK: - WKUIDelegate
    func webView(_ webView: WKWebView, createWebViewWith configuration: WKWebViewConfiguration, for navigationAction: WKNavigationAction, windowFeatures: WKWindowFeatures) -> WKWebView? {
        // target=_blank対策
        if navigationAction.targetFrame == nil {
            webView.load(navigationAction.request)
        }
        return nil
    }
}
