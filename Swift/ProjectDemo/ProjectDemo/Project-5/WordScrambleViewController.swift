//
//  WordScrambleViewController.swift
//  ProjectDemo
//
//  Created by QDSG on 2021/5/31.
//

import UIKit

class WordScrambleViewController: UITableViewController {
    
    private var wallWords = [String]()
    private var usedWords = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
//         self.clearsSelectionOnViewWillAppear = false
        
        tableView.tableFooterView = UIView()
        tableView.register(UITableViewCell.self,
                           forCellReuseIdentifier: UITableViewCell.reuseIdentifier())
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(promptForAnswer))
        
        if let startWordsPath = Bundle.main.path(forResource: "start", ofType: "txt") {
            if let startWords = try? String(contentsOfFile: startWordsPath) {
                wallWords = startWords.components(separatedBy: "\n")
            }
        } else {
            wallWords = ["silkworm"]
        }
        
        startGame()
    }
    
    private func startGame() {
        title = wallWords.randomElement()
        usedWords.removeAll(keepingCapacity: true)
        tableView.reloadData()
    }
    
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return usedWords.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: UITableViewCell.reuseIdentifier(), for: indexPath)
        cell.textLabel?.text = usedWords[indexPath.row]
        return cell
    }

    @objc private func promptForAnswer() {
        let alert = UIAlertController(title: "输入答案", message: nil, preferredStyle: .alert)
        alert.addTextField()
        
        let submitAction = UIAlertAction(title: "提交", style: .default) { [unowned self, alert] action in
            if let answer = alert.textFields?[0], let text = answer.text {
                self.submit(answer: text)
            }
        }
        
        alert.addAction(submitAction)
        present(alert, animated: true)
    }
    
    private func submit(answer: String) {
        let lowerAnswer = answer.lowercased()
        
        let errorTitle: String
        let errorMessage: String
        
        guard isPossible(word: lowerAnswer) else {
            errorTitle = "Word not possible"
            errorMessage = "You can't spell that word from '\(title?.lowercased() ?? "xxx")'！"
            
            alert(title: errorTitle, message: errorMessage)
            
            return
        }
        
        guard isOriginal(word: lowerAnswer) else {
            errorTitle = "Word used already"
            errorMessage = "Be more original!"
            
            alert(title: errorTitle, message: errorMessage)
            
            return
        }
        
        guard isReal(word: lowerAnswer) else {
            errorTitle = "Word not recognised"
            errorMessage = "You can't just make them up, you know!"
            
            alert(title: errorTitle, message: errorMessage)
            
            return
        }
        
        usedWords.insert(lowerAnswer, at: 0)
        
        let indexPath = IndexPath(row: 0, section: 0)
        tableView.insertRows(at: [indexPath], with: .automatic)
    }
    
    private func alert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "好的", style: .default))
        present(alert, animated: true)
    }
    
    private func isPossible(word: String) -> Bool {
        var tempWord = title?.lowercased()
        
        for letter in word {
            guard let pos = tempWord?.range(of: String(letter)) else {
                return false
            }
            
            tempWord?.remove(at: pos.lowerBound)
        }
        
        return true
    }
    
    private func isOriginal(word: String) -> Bool {
        return !usedWords.contains(word)
    }
    
    private func isReal(word: String) -> Bool {
        let checker = UITextChecker()
        let range = NSRange(location: 0, length: word.utf16.count)
        let misspelledRange = checker.rangeOfMisspelledWord(in: word, range: range, startingAt: 0, wrap: false, language: "en")
        
        return misspelledRange.location == NSNotFound
    }
}
