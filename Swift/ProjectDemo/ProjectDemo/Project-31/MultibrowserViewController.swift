//
//  MultibrowserViewController.swift
//  ProjectDemo
//
//  Created by QDSG on 2021/6/4.
//

import UIKit
import WebKit

class MultibrowserViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        setDefaultTitle()
        
        let addItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addWebView))
        let deleteItem = UIBarButtonItem(barButtonSystemItem: .trash, target: self, action: #selector(deleteWebView))
        navigationItem.rightBarButtonItems = [deleteItem, addItem]
    }
    
    private weak var activeWebView: WKWebView?

    @IBOutlet private weak var addressBar: UITextField!
    @IBOutlet private weak var stackView: UIStackView!
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        if traitCollection.horizontalSizeClass == .compact {
            stackView.axis = .vertical
        } else {
            stackView.axis = .horizontal
        }
    }
    
}

// MARK: - Private Methods

extension MultibrowserViewController {
    private func setDefaultTitle() {
        title = "Multibrowser"
    }
    
    private func selectWebView(_ webView: WKWebView) {
        for view in stackView.arrangedSubviews {
            view.layer.borderWidth = 0
        }
        
        activeWebView = webView
        webView.layer.borderWidth = 3
        
        updateUI(for: webView)
    }
    
    private func updateUI(for webView: WKWebView) {
        title = webView.title
        addressBar.text = webView.url?.absoluteString
    }
}

// MARK: - Actions

extension MultibrowserViewController {
    @objc private func addWebView() {
        let webView = WKWebView()
        webView.navigationDelegate = self
        
        stackView.addArrangedSubview(webView)
        
        let url = URL(string: "https://www.hackingwithswift.com")!
        webView.load(URLRequest(url: url))
        
        webView.layer.borderColor = UIColor.blue.cgColor
        selectWebView(webView)
        
        let gesture = UITapGestureRecognizer(target: self, action: #selector(webViewTapped))
        gesture.delegate = self
        webView.addGestureRecognizer(gesture)
    }
    
    @objc private func deleteWebView() {
        guard let webView = activeWebView else { return }
        
        guard let index = stackView.arrangedSubviews.firstIndex(of: webView) else { return }
        
        stackView.removeArrangedSubview(webView)
        
        webView.removeFromSuperview()
        
        if stackView.arrangedSubviews.count == 0 {
            setDefaultTitle()
        } else {
            var currentIndex = Int(index)
            
            if currentIndex == stackView.arrangedSubviews.count {
                currentIndex = stackView.arrangedSubviews.count - 1
            }
            
            if let newSelectedWebView = stackView.arrangedSubviews[currentIndex] as? WKWebView {
                selectWebView(newSelectedWebView)
            }
        }
    }
    
    @objc private func webViewTapped(_ gesture: UITapGestureRecognizer) {
        if let selectedWebView = gesture.view as? WKWebView {
            selectWebView(selectedWebView)
        }
    }
}

// MARK: - WKNavigationDelegate

extension MultibrowserViewController: WKNavigationDelegate {
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        if webView == activeWebView {
            updateUI(for: webView)
        }
    }
}

// MARK: - UIGestureRecognizerDelegate

extension MultibrowserViewController: UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
}

extension MultibrowserViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if let webView = activeWebView,
           let address = addressBar.text {
            if let url = URL(string: address) {
                webView.load(URLRequest(url: url))
            }
        }
        
        textField.resignFirstResponder()
        return true
    }
}
