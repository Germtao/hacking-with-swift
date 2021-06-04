//
//  SecretSwiftViewController.swift
//  ProjectDemo
//
//  Created by QDSG on 2021/6/3.
//

import UIKit
import LocalAuthentication

class SecretSwiftViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Nothing to see here"
        
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(adjustForKeyboard), name: UIResponder.keyboardWillHideNotification, object: nil)
        notificationCenter.addObserver(self, selector: #selector(adjustForKeyboard), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
        notificationCenter.addObserver(self, selector: #selector(saveSecretMessage), name: UIApplication.willResignActiveNotification, object: nil)
    }

    @IBOutlet private weak var textView: UITextView!
    
    @objc private func unlockSecretMessage() {
        textView.isHidden = false
        title = "Secret stuff!"
        
        if let text = KeychainWrapper.standard.string(forKey: "SecretMessage") {
            textView.text = text
        }
    }
    
    @IBAction private func authenticateTapped() {
        let context = LAContext()
        var error: NSError?
        
        if context.canEvaluatePolicy(.deviceOwnerAuthentication, error: &error) {
            let reason = "Identify yourself!"
            
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { success, error in
                DispatchQueue.main.async {
                    if success {
                        self.unlockSecretMessage()
                    } else {
                        let alert = UIAlertController(title: "授权失败", message: "您无法通过验证，请再试一次。", preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: "好的", style: .default))
                        self.present(alert, animated: true)
                    }
                }
            }
        } else {
            let alert = UIAlertController(title: "Touch ID、Face ID 不可用", message: "您的设备未配置生物识别身份验证。", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "我知道了", style: .default))
            present(alert, animated: true)
        }
    }
    
    @objc private func adjustForKeyboard(_ noti: Notification) {
        guard let keyboardScreenEndFrameValue = noti.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else { return }
        
        let keyboardViewEndFrame = view.convert(keyboardScreenEndFrameValue.cgRectValue, to: view.window)
        
        if noti.name == UIResponder.keyboardWillHideNotification {
            textView.contentInset = .zero
        } else {
            textView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardViewEndFrame.height, right: 0)
        }
        
        textView.scrollIndicatorInsets = textView.contentInset
        
        textView.scrollRangeToVisible(textView.selectedRange)
    }
    
    @objc private func saveSecretMessage() {
        if !textView.isHidden {
            KeychainWrapper.standard.set(textView.text, forKey: "SecretMessage")
            
            textView.resignFirstResponder()
            textView.isHidden = true
            
            title = "Nothing to see here"
        }
    }
}
