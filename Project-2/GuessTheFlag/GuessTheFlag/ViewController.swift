//
//  ViewController.swift
//  GuessTheFlag
//
//  Created by QDSG on 2020/8/25.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var button1: UIButton! {
        didSet {
            button1.layer.cornerRadius = 8
            button1.layer.borderWidth = 1
            button1.layer.borderColor = UIColor.lightGray.cgColor
            button1.clipsToBounds = true
        }
    }
    
    @IBOutlet weak var button2: UIButton! {
        didSet {
            button2.layer.cornerRadius = 8
            button2.layer.borderWidth = 1
            button2.layer.borderColor = UIColor.lightGray.cgColor
            button2.clipsToBounds = true
        }
    }
    
    @IBOutlet weak var button3: UIButton! {
        didSet {
            button3.layer.cornerRadius = 8
            button3.layer.borderWidth = 1
            button3.layer.borderColor = UIColor.lightGray.cgColor
            button3.clipsToBounds = true
        }
    }
    
    var countries = [String]()
    var correctAnswer = 0
    var score = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        
        countries += ["estonia", "france", "germany", "ireland", "italy", "monaco", "nigeria", "poland", "russia", "spain", "uk", "us"]
        askQuestion()
    }
    
    private func askQuestion(action: UIAlertAction? = nil) {
        // 洗牌
        countries.shuffle()
        
        button1.setImage(UIImage(named: countries[0]), for: .normal)
        button2.setImage(UIImage(named: countries[1]), for: .normal)
        button3.setImage(UIImage(named: countries[2]), for: .normal)
        
        correctAnswer = Int.random(in: 0...2)
        title = countries[correctAnswer].uppercased() // 大写
    }
    
    @IBAction func buttonTapped(_ sender: UIButton) {
        var title: String
        
        if sender.tag == correctAnswer {
            title = "✅ 正确"
            score += 1
        } else {
            title = "❎ 错误"
            score -= 1
        }
        
        let ac = UIAlertController(title: title, message: "你的分数 \(score)", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "继续", style: .default, handler: askQuestion))
        present(ac, animated: true)
    }
}

