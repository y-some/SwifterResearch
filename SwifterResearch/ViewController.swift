//
//  ViewController.swift
//  SwifterResearch
//
//  Created by Yasuyuki Someya on 2018/11/18.
//  Copyright © 2018年 Yasuyuki Someya. All rights reserved.
//

import UIKit
import WebKit

class ViewController: UIViewController, WKUIDelegate {

    lazy var webView: WKWebView = {
        let webConfiguration = WKWebViewConfiguration()
        let webView = WKWebView(frame: .zero, configuration: webConfiguration)
        webView.translatesAutoresizingMaskIntoConstraints = false
        webView.uiDelegate = self
        webView.navigationDelegate = self
        return webView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(webView)
        // WebViewのページロード
        guard let url = URL(string: AppDelegate.urlString) else {
            return
        }
        webView.load(URLRequest(url: url))
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        webView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0.0).isActive = true
        webView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0.0).isActive = true
        webView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0.0).isActive = true
        webView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0.0).isActive = true
    }
}

extension ViewController: WKNavigationDelegate {
    /// ページ遷移
    func webView(_ webView: WKWebView,
                 decidePolicyFor navigationAction: WKNavigationAction,
                 decisionHandler: (WKNavigationActionPolicy) -> Void) {
        guard let naviUrl = navigationAction.request.url else {
            decisionHandler(.cancel)
            return
        }
        if naviUrl.scheme?.contains("hoge") ?? false {
            // URLスキームの場合：例えばAlertを表示してみる
            let alert = UIAlertController(title: "",
                                          message: "URLスキームのリンクがtapされました。",
                                          preferredStyle: .alert)
            let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alert.addAction(action)
            self.present(alert, animated: true, completion: nil)
            decisionHandler(.cancel)
        } else {
            decisionHandler(.allow)
        }
    }
}
