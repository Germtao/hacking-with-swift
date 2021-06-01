//
//  SwiftyWordsViewController.swift
//  ProjectDemo
//
//  Created by QDSG on 2021/6/1.
//

import UIKit

class SwiftyWordsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        loadLevel()
    }
    
    private func loadLevel() {
        var clueString = ""
        var solutionString = ""
        var letterBits = [String]()
        
        if let levelFilePath = Bundle.main.path(forResource: "level\(level)", ofType: "txt") {
            if let levelContents = try? String(contentsOfFile: levelFilePath) {
                var lines = levelContents.components(separatedBy: "\n")
                lines.shuffle()
                
                for (index, line) in lines.enumerated() {
                    let parts = line.components(separatedBy: ": ")
                    let answer = parts[0]
                    let clue = parts[1]
                    
                    clueString += "\(index + 1). \(clue)\n"
                    
                    let solutionWord = answer.replacingOccurrences(of: "|", with: "")
                    solutionString += "\(solutionWord.count)letters\n"
                    solutions.append(solutionWord)
                    
                    let bits = answer.components(separatedBy: "|")
                    letterBits += bits
                }
            }
        }
        
        cluesLabel.text = clueString.trimmingCharacters(in: .whitespacesAndNewlines)
        answersLabel.text = solutionString.trimmingCharacters(in: .whitespacesAndNewlines)
        
        letterBits.shuffle()
        
        if letterBits.count == letterButtons.count {
            for i in 0..<letterBits.count {
                letterButtons[i].setTitle(letterBits[i], for: .normal)
            }
        }
    }
    
    @IBAction private func clearTapped(_ sender: UIButton) {
        currentAnswer.text = ""
        activatedButtons.forEach { $0.isHidden = false }
        activatedButtons.removeAll()
    }
    
    @IBAction private func submitTapped(_ sender: UIButton) {
        guard let solutionPosition = solutions.firstIndex(of: currentAnswer.text!) else { return }
        
        activatedButtons.removeAll()
        
        var splitAnswers = answersLabel.text?.components(separatedBy: "\n")
        splitAnswers?[solutionPosition] = currentAnswer.text!
        answersLabel.text = splitAnswers?.joined(separator: "\n")
        
        currentAnswer.text = ""
        score += 1
        
        if score % 7 == 0 {
            let alert = UIAlertController(title: "Well done!",
                                          message: "Are you ready for the next level?",
                                          preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Let's go!", style: .default, handler: levelUp))
            present(alert, animated: true)
        }
    }
    
    @IBAction private func letterTapped(_ sender: UIButton) {
        currentAnswer.text = currentAnswer.text! + (sender.title(for: .normal) ?? "")
        activatedButtons.append(sender)
        sender.isHidden = true
    }
    
    private func levelUp(_ action: UIAlertAction) {
        level += 1
        solutions.removeAll(keepingCapacity: true)
        
        loadLevel()
        
        letterButtons.forEach { $0.isHidden = false }
    }
    
    private var level = 1
    
    private var score = 0 {
        didSet { scoreLabel.text = "Score: \(score)" }
    }

    @IBOutlet private weak var cluesLabel: UILabel!
    @IBOutlet private weak var answersLabel: UILabel!
    @IBOutlet private weak var currentAnswer: UITextField!
    @IBOutlet private weak var scoreLabel: UILabel!
    
    @IBOutlet private var letterButtons: [UIButton]!
    
    private var activatedButtons = [UIButton]()
    private var solutions = [String]()
}
