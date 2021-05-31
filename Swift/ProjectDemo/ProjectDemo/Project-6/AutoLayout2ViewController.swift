//
//  AutoLayout2ViewController.swift
//  ProjectDemo
//
//  Created by QDSG on 2021/5/31.
//

import UIKit

class AutoLayout2ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "AutoLayout - 2"
        view.backgroundColor = .white

        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isTranslucent = false
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.navigationBar.isTranslucent = true
    }
    
    private func layoutUIWithAnchors(_ label1: UILabel, _ label2: UILabel, _ label3: UILabel, _ label4: UILabel, _ label5: UILabel) {
        
        let views = [label1, label2, label3, label4, label5]
        
        var previous: UILabel?
        
        for label in views {
            label.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
            label.heightAnchor.constraint(equalToConstant: 88).isActive = true
            
            if let previous = previous {
                label.topAnchor.constraint(equalTo: previous.bottomAnchor, constant: 10).isActive = true
            }
            
            previous = label
        }
    }
    
    private func layoutUIWithVFL(_ label1: UILabel, _ label2: UILabel, _ label3: UILabel, _ label4: UILabel, _ label5: UILabel) {
        
        let viewsDict = ["label1": label1, "label2": label2, "label3": label3, "label4": label4, "label5": label5]
        
        for label in viewsDict.keys {
            view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[\(label)]|", options: [], metrics: nil, views: viewsDict))
        }
        
        let metrics = ["labelHeight": 88]
        
        let v = "V:|[label1(labelHeight@999)]-[label2(label1)]-[label3(label1)]-[label4(label1)]-[label5(label1)]->=10-|"
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: v, options: [], metrics: metrics, views: viewsDict))
    }

    private func setupUI() {
        let label1 = UILabel()
        label1.translatesAutoresizingMaskIntoConstraints = false
        label1.backgroundColor = .red
        label1.text = "THESE"
        
        let label2 = UILabel()
        label2.translatesAutoresizingMaskIntoConstraints = false
        label2.backgroundColor = .cyan
        label2.text = "ARE"
        
        let label3 = UILabel()
        label3.translatesAutoresizingMaskIntoConstraints = false
        label3.backgroundColor = .yellow
        label3.text = "SOME"
        
        let label4 = UILabel()
        label4.translatesAutoresizingMaskIntoConstraints = false
        label4.backgroundColor = .green
        label4.text = "AWESOME"
        
        let label5 = UILabel()
        label5.translatesAutoresizingMaskIntoConstraints = false
        label5.backgroundColor = .orange
        label5.text = "LABELS"
        
        view.addSubview(label1)
        view.addSubview(label2)
        view.addSubview(label3)
        view.addSubview(label4)
        view.addSubview(label5)
        
//        layoutUIWithVFL(label1, label2, label3, label4, label5)
        layoutUIWithAnchors(label1, label2, label3, label4, label5)
    }

}
