//
//  ViewController.swift
//  AutoLayout
//
//  Created by QDSG on 2020/8/31.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
}

private extension ViewController {
    func setupUI() {
        let label1 = createLabel("THESE", backgroundColor: .red)
        
        let label2 = createLabel("ARE", backgroundColor: .cyan)
        
        let label3 = createLabel("SOME", backgroundColor: .yellow)
        
        let label4 = createLabel("AWESOME", backgroundColor: .green)
        
        let label5 = createLabel("LABELS", backgroundColor: .orange)
        
        view.addSubview(label1)
        view.addSubview(label2)
        view.addSubview(label3)
        view.addSubview(label4)
        view.addSubview(label5)
        
        setupUILayout(label1, label2, label3, label4, label5)
    }
    
    func setupUILayout(_ label1: UILabel, _ label2: UILabel, _ label3: UILabel, _ label4: UILabel, _ label5: UILabel) {
//        let viewsDict = ["label1": label1, "label2": label2, "label3": label3, "label4": label4, "label5": label5]
//
//        for label in viewsDict.keys {
//            view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[\(label)]|",
//                                                               options: [],
//                                                               metrics: nil,
//                                                               views: viewsDict))
//        }
//
//        let metrics = ["labelHeight": 88]
//
//        view.addConstraints(NSLayoutConstraint.constraints(
//                                withVisualFormat: "V:|[label1(labelHeight@999)]-[label2(label1)]-[label3(label1)]-[label4(label1)]-[label5(label1)]->=10-|",
//                                options: [],
//                                metrics: metrics,
//                                views: viewsDict)
//        )
        
        var previous: UILabel?
        
        for label in [label1, label2, label3, label4, label5] {
            label.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
            label.heightAnchor.constraint(equalToConstant: 88).isActive = true
            
            if let _previous = previous {
                label.topAnchor.constraint(equalTo: _previous.bottomAnchor, constant: 10).isActive = true
            }
            
            previous = label
        }
    }
    
    func createLabel(_ text: String, backgroundColor: UIColor) -> UILabel {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = backgroundColor
        label.textAlignment = .center
        label.text = text
        return label
    }
}

