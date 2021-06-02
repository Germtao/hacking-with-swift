//
//  JavascriptInjectionViewController.swift
//  ProjectDemo
//
//  Created by QDSG on 2021/6/2.
//

import UIKit
import MobileCoreServices

class JavascriptInjectionViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(done))
        
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(adjustForKeyboard), name: UIResponder.keyboardWillHideNotification, object: nil)
        notificationCenter.addObserver(self, selector: #selector(adjustForKeyboard), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
        
        guard let inputItem = extensionContext?.inputItems.first as? NSExtensionItem else { return }
        
        guard let itemProvider = inputItem.attachments?.first else { return }
        
        itemProvider.loadItem(forTypeIdentifier: kUTTypePropertyList as String) { dict, error in
            guard let itemDict = dict as? NSDictionary,
                  let javascriptValues = itemDict[NSExtensionJavaScriptPreprocessingResultsKey] as? NSDictionary else { return }
            
            self.pageTitle = javascriptValues["title"] as? String
            self.pageURL = javascriptValues["URL"] as? String

            DispatchQueue.main.async {
                self.title = self.pageTitle
            }
        }
        
    }
    
    private var pageTitle: String?
    private var pageURL: String?

    @IBOutlet private weak var script: UITextView!
    
    @objc private func done() {
        let item = NSExtensionItem()
        let argument = ["customJavaScript": script.text]
        
        let webArgument: NSDictionary = [NSExtensionJavaScriptFinalizeArgumentKey: argument]
        
        let customJavascript = NSItemProvider(item: webArgument, typeIdentifier: kUTTypePropertyList as String)
        
        item.attachments = [customJavascript]
        
        extensionContext?.completeRequest(returningItems: [item])
    }
    
    @objc private func adjustForKeyboard(_ noti: Notification) {
        guard let userInfo = noti.userInfo else { return }
        
        let keyboardScreenEndFrame = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        
        let keyboardViewEndFrame = view.convert(keyboardScreenEndFrame, to: view.window)
        
        if noti.name == UIResponder.keyboardWillHideNotification {
            script.contentInset = .zero
        } else {
            script.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardViewEndFrame.height, right: 0)
        }
        
        script.scrollIndicatorInsets = script.contentInset
        
        script.scrollRangeToVisible(script.selectedRange)
    }
}
