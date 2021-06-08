//
//  WhistleViewController.swift
//  ProjectDemo
//
//  Created by QDSG on 2021/6/7.
//

import UIKit
import CloudKit

class WhistleViewController: UITableViewController {
    
    private var whistles: [Whistle] = [] {
        didSet { tableView.reloadData() }
    }
    
    static var isDirty = true

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "What's that Whistle?"
        view.backgroundColor = .white
        
        let selectItem = UIBarButtonItem(title: "Genres", style: .plain, target: self, action: #selector(selectGenre))
        let addItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addWhistle))
        navigationItem.rightBarButtonItems = [addItem, selectItem]
        
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "Home", style: .plain, target: nil, action: nil)
        
        tableView.tableFooterView = UIView()
        tableView.register(UITableViewCell.self,
                           forCellReuseIdentifier: UITableViewCell.reuseIdentifier())
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if let indexPath = tableView.indexPathForSelectedRow {
            tableView.deselectRow(at: indexPath, animated: true)
        }
        
        if WhistleViewController.isDirty {
            loadWhistles()
        }
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return whistles.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: UITableViewCell.reuseIdentifier(), for: indexPath)

        cell.accessoryType = .disclosureIndicator
        
        let whistle = whistles[indexPath.row]
        
        cell.textLabel?.attributedText = makeAttributedString(title: whistle.genre ?? "", subtitle: whistle.comments ?? "")
        cell.textLabel?.numberOfLines = 0

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = ResultsViewController()
        vc.whistle = whistles[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
    }

}

extension WhistleViewController {
    private func loadWhistles() {
        let pred = NSPredicate(value: true)
        let sort = NSSortDescriptor(key: "creationDate", ascending: false)
        let query = CKQuery(recordType: "Whistles", predicate: pred)
        query.sortDescriptors = [sort]
        
        let operation = CKQueryOperation(query: query)
        operation.desiredKeys = ["genre", "comments"]
        operation.resultsLimit = 50
        
        var newWhistles = [Whistle]()
        
        operation.recordFetchedBlock = { record in
            var whistle = Whistle()
            whistle.recordID = record.recordID
            whistle.genre = record["genre"]
            whistle.comments = record["comments"]
            newWhistles.append(whistle)
        }
        
        operation.queryCompletionBlock = { cursor, error in
            DispatchQueue.main.async {
                if error == nil {
                    WhistleViewController.isDirty = false
                    self.whistles = newWhistles
                } else {
                    let alert = UIAlertController(title: "获取失败", message: "获取歌曲列表时出现问题； 请重试：\(error!.localizedDescription)", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "我知道了", style: .default))
                    self.present(alert, animated: true)
                }
            }
        }
        
        CKContainer.default().publicCloudDatabase.add(operation)
    }
    
    private func makeAttributedString(title: String, subtitle: String) -> NSAttributedString {
        let titleAttributes = [
            NSAttributedString.Key.font: UIFont.preferredFont(forTextStyle: .headline),
            NSAttributedString.Key.foregroundColor: UIColor.purple
        ]
        
        let subtitleAttributes = [
            NSAttributedString.Key.font: UIFont.preferredFont(forTextStyle: .subheadline)
        ]
        
        let titleAttrStr = NSMutableAttributedString(string: title, attributes: titleAttributes)
        
        if subtitle.count > 0 {
            let subtitleAttrStr = NSAttributedString(string: "\n\(subtitle)", attributes: subtitleAttributes)
            titleAttrStr.append(subtitleAttrStr)
        }
        
        return titleAttrStr
    }
}

// MARK: - Actions

extension WhistleViewController {
    @objc private func selectGenre() {
        let vc = MyGenresViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc private func addWhistle() {
        let vc = RecordWhistleViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
}
