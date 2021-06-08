//
//  ResultsViewController.swift
//  ProjectDemo
//
//  Created by QDSG on 2021/6/8.
//

import UIKit
import CloudKit
import AVFoundation

class ResultsViewController: UITableViewController {
    
    var whistle: Whistle?
    
    private var suggestions: [String] = [] {
        didSet {
            DispatchQueue.main.async { [unowned self] in
                self.tableView.reloadData()
            }
        }
    }
    
    private var whistlePlayer: AVAudioPlayer?

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Genre: \(whistle?.genre ?? "")"
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Download", style: .plain, target: self, action: #selector(downloadTapped))
        
        tableView.register(UITableViewCell.self,
                           forCellReuseIdentifier: UITableViewCell.reuseIdentifier())
    }
    
    private func loadData() {
        let reference = CKRecord.Reference(recordID: whistle?.recordID ?? CKRecord.ID(), action: .deleteSelf)
        let pred = NSPredicate(format: "owningWhistle == %@", reference)
        let sort = NSSortDescriptor(key: "creationDate", ascending: true)
        let query = CKQuery(recordType: "Suggestions", predicate: pred)
        query.sortDescriptors = [sort]
        
        CKContainer.default().publicCloudDatabase.perform(query, inZoneWith: nil) { results, error in
            if let error = error {
                print(error.localizedDescription)
            } else {
                if let results = results {
                    self.parseResults(results)
                }
            }
        }
    }
    
    private func parseResults(_ records: [CKRecord]) {
        var newSuggestion = [String]()
        
        records.forEach {
            if let text = $0["text"] as? String {
                newSuggestion.append(text)
            }
        }
        
        suggestions = newSuggestion
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return section == 0 ? 1 : max(1, suggestions.count + 1)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: UITableViewCell.reuseIdentifier(), for: indexPath)

        cell.selectionStyle = .none
        cell.textLabel?.numberOfLines = 0
        
        if indexPath.section == 0 {
            cell.textLabel?.font = UIFont.preferredFont(forTextStyle: .title1)
            
            if whistle?.comments?.count == 0 {
                cell.textLabel?.text = "Comments: None"
            } else {
                cell.textLabel?.text = whistle?.comments
            }
        } else {
            cell.textLabel?.font = UIFont.preferredFont(forTextStyle: .body)
            
            if indexPath.row == suggestions.count {
                cell.textLabel?.text = "Add suggestion"
                cell.selectionStyle = .gray
            } else {
                cell.textLabel?.text = suggestions[indexPath.row]
            }
        }

        return cell
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return section == 1 ? "Suggested songs" : nil
    }
    
    override func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard indexPath.section == 1 && indexPath.row == suggestions.count else {
            return
        }
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        let alert = UIAlertController(title: "Suggest a song...", message: nil, preferredStyle: .alert)
        alert.addTextField()
        
        alert.addAction(UIAlertAction(title: "Submit", style: .default, handler: { [unowned self, alert] _ in
            if let textField = alert.textFields?.first {
                if textField.text!.count > 0 {
                    self.add(suggestion: textField.text!)
                }
            }
        }))
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        present(alert, animated: true)
    }
    
    private func add(suggestion: String) {
        let whistleRecord = CKRecord(recordType: "Suggestions")
        let reference = CKRecord.Reference(recordID: whistle?.recordID ?? CKRecord.ID(), action: .deleteSelf)
        whistleRecord["text"] = suggestion as CKRecordValue
        whistleRecord["owningWhistle"] = reference as CKRecordValue
        
        CKContainer.default().publicCloudDatabase.save(whistleRecord) { record, error in
            DispatchQueue.main.async {
                guard let error = error else {
                    self.suggestions.append(suggestion)
                    return
                }
                
                let alert = UIAlertController(title: "Error", message: "There was a problem submitting your suggestion: \(error.localizedDescription)", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default))
                self.present(alert, animated: true)
            }
        }
    }

    @objc private func downloadTapped() {
        let spinner = UIActivityIndicatorView(style: .large)
        spinner.tintColor = .black
        spinner.startAnimating()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: spinner)
        
        guard let recordID = whistle?.recordID else { return }
        
        CKContainer.default().publicCloudDatabase.fetch(withRecordID: recordID) { record, error in
            if let error = error {
                DispatchQueue.main.async {
                    print(error.localizedDescription)
                    
                    self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Download", style: .plain, target: self, action: #selector(self.downloadTapped))
                }
            } else {
                if let record = record {
                    guard let asset = record["audio"] as? CKAsset else { return }
                    
                    self.whistle?.audio = asset.fileURL
                    
                    DispatchQueue.main.async {
                        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Listen", style: .plain, target: self, action: #selector(self.listenTapped))
                    }
                }
            }
        }
    }
    
    @objc private func listenTapped() {
        do {
            guard let audioURL = whistle?.audio else { return }
            whistlePlayer = try AVAudioPlayer(contentsOf: audioURL)
            whistlePlayer?.play()
        } catch {
            let alert = UIAlertController(title: "Playback failed", message: "There was a problem playing your whistle; please try re-recording.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            present(alert, animated: true)
        }
    }
}
