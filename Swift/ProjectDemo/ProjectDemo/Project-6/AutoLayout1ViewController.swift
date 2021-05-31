//
//  AutoLayout1ViewController.swift
//  ProjectDemo
//
//  Created by QDSG on 2021/5/31.
//

import UIKit

class AutoLayout1ViewController: UIViewController {
    
    private var countries: [String] = []
    private var correctAnswer = 0
    private var score = 0

    override func viewDidLoad() {
        super.viewDidLoad()

        countries += ["estonia", "france", "germany", "ireland", "italy", "monaco", "nigeria", "poland", "russia", "spain", "uk", "us"]
        
        askQuestion()
    }
    
    private func askQuestion(_ action: UIAlertAction? = nil) {
        countries.shuffle()
        
        button1.setImage(UIImage(named: countries[0]), for: .normal)
        button2.setImage(UIImage(named: countries[1]), for: .normal)
        button3.setImage(UIImage(named: countries[2]), for: .normal)
        
        correctAnswer = Int.random(in: 0...2)
        title = countries[correctAnswer].uppercased()
    }
    
    @IBAction private func buttonTapped(_ sender: UIButton) {
        var title: String
        
        if sender.tag == correctAnswer {
            title = "✅ 正确"
            score += 1
        } else {
            title = "❌ 错误"
            score -= 1
        }
        
        let alert = UIAlertController(title: title,
                                      message: "你的得分 \(score)",
                                      preferredStyle: .alert)
        let action = UIAlertAction(title: "继续", style: .default, handler: askQuestion)
        alert.addAction(action)
        
        present(alert, animated: true)
    }

    @IBOutlet private weak var button1: UIButton! {
        didSet {
            button1.layer.borderWidth = 1
            button1.layer.borderColor = UIColor.lightGray.cgColor
        }
    }
    @IBOutlet private weak var button2: UIButton! {
        didSet {
            button2.layer.borderWidth = 1
            button2.layer.borderColor = UIColor.lightGray.cgColor
        }
    }
    @IBOutlet private weak var button3: UIButton! {
        didSet {
            button3.layer.borderWidth = 1
            button3.layer.borderColor = UIColor.lightGray.cgColor
        }
    }

}
