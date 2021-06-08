//
//  SubmitViewController.swift
//  ProjectDemo
//
//  Created by QDSG on 2021/6/7.
//

import UIKit
import CloudKit

class SubmitViewController: UIViewController {
    
    var genre: String?
    var comments: String?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "You're all set!"

        view.backgroundColor = .gray
        
        navigationItem.hidesBackButton = true
        
        stackView.addArrangedSubview(statusLabel)
        stackView.addArrangedSubview(spinner)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        doSubmission()
    }
    
    private func doSubmission() {
        let whistleRecord = CKRecord(recordType: "Whistles")
        whistleRecord["genre"] = genre as CKRecordValue?
        whistleRecord["comments"] = comments as CKRecordValue?
        
        let audioURL = RecordWhistleViewController.getWhistleURL()
        let whistleAsset = CKAsset(fileURL: audioURL)
        whistleRecord["audio"] = whistleAsset
        
        CKContainer.default().publicCloudDatabase.save(whistleRecord) { record, error in
            DispatchQueue.main.async {
                if let error = error {
                    self.statusLabel.text = "Error: \(error.localizedDescription)"
                } else {
                    self.view.backgroundColor = UIColor(red: 0, green: 0.6, blue: 0, alpha: 1)
                    self.statusLabel.text = "Done!"
                    
                    WhistleViewController.isDirty = true
                }
                
                self.spinner.stopAnimating()
                
                self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(self.doneTapped))
            }
        }
    }
    
    @objc private func doneTapped() {
        navigationController?.popToRootViewController(animated: true)
    }
    
    private lazy var spinner: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView(style: .large)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.hidesWhenStopped = true
        view.startAnimating()
        return view
    }()
    
    private lazy var statusLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Submitting..."
        label.textColor = .white
        label.font = UIFont.preferredFont(forTextStyle: .title1)
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()

    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.spacing = 10
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.distribution = .fillEqually
        stackView.alignment = .center
        stackView.axis = .vertical
        view.addSubview(stackView)
        
        stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
        return stackView
    }()

}
