//
//  AddCommentsViewController.swift
//  ProjectDemo
//
//  Created by QDSG on 2021/6/7.
//

import UIKit

class AddCommentsViewController: UIViewController, UITextViewDelegate {
    
    var genre: String?
    
    private let placeholder = "If you have any additional comments that might help identify your tune, enter them here."

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Comments"
        view.backgroundColor = .white
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Submit", style: .plain, target: self, action: #selector(submitTapped))
        
        comments.text = placeholder
    }
    
    @objc private func submitTapped() {
        let vc = SubmitViewController()
        vc.genre = genre
        
        if comments.text == placeholder {
            vc.comments = ""
        } else {
            vc.comments = comments.text
        }
        
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.text == placeholder {
            textView.text = ""
        }
    }
    
    private lazy var comments: UITextView = {
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.delegate = self
        textView.font = UIFont.preferredFont(forTextStyle: .body)
        view.addSubview(textView)
        
        textView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        textView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        textView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        textView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        
        return textView
    }()

}
