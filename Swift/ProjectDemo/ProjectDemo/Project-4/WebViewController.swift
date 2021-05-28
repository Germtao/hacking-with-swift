//
//  WebViewController.swift
//  ProjectDemo
//
//  Created by QDSG on 2021/5/28.
//

import UIKit
import WebKit

class WebViewController: UIViewController, WKNavigationDelegate {
    
    private var webView: WKWebView!
    private var progressView: UIProgressView!
    
    private var websites = ["apple.com", "hackingwithswift.com"]
    
    override func loadView() {
        webView = WKWebView()
        webView.navigationDelegate = self
        view = webView
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        guard let url = URL(string: "https://" + websites[0]) else { return }
        webView.load(URLRequest(url: url))
        webView.allowsBackForwardNavigationGestures = true
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "打开", style: .plain, target: self, action: #selector(openTapped))
        
        progressView = UIProgressView(progressViewStyle: .default)
        progressView.sizeToFit()
        let progressItem = UIBarButtonItem(customView: progressView)
        
    }
    
    @objc private func openTapped() {
        
    }
    

}
