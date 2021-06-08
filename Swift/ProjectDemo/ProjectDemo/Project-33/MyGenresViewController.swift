//
//  MyGenresViewController.swift
//  ProjectDemo
//
//  Created by QDSG on 2021/6/7.
//

import UIKit
import CloudKit

class MyGenresViewController: UITableViewController {
    
    private var myGenres: [String] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Notify me about…"
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(saveTapped))
        
        let defaults = UserDefaults.standard
        if let savedGenres = defaults.array(forKey: "myGenres") as? [String] {
            myGenres = savedGenres
        }
        
        tableView.register(UITableViewCell.self,
                           forCellReuseIdentifier: UITableViewCell.reuseIdentifier())
    }
    
    @objc private func saveTapped() {
        UserDefaults.standard.set(myGenres, forKey: "myGenres")
        
        let database = CKContainer.default().publicCloudDatabase
        
        database.fetchAllSubscriptions { subscriptions, error in
            if error == nil {
                if let subscriptions = subscriptions {
                    for subscription in subscriptions {
                        database.delete(withSubscriptionID: subscription.subscriptionID) { str, error in
                            if error != nil {
                                print(error!.localizedDescription)
                            }
                        }
                    }
                    
                    for genre in self.myGenres {
                        let pred = NSPredicate(format: "genre = %@", genre)
                        let subscription = CKQuerySubscription(recordType: "Whistles", predicate: pred, options: .firesOnRecordCreation)
                        
                        let notification = CKSubscription.NotificationInfo()
                        notification.alertBody = "There's a new whistle in the \(genre) genre."
                        notification.soundName = "default"
                        
                        subscription.notificationInfo = notification
                        
                        database.save(subscription) { result, error in
                            if let error = error {
                                print("database save error: \(error.localizedDescription)")
                            }
                        }
                    }
                }
            } else {
                print("database fetch all subscriptions error: \(error!.localizedDescription)")
            }
        }
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return SelectGenreViewController.genres.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: UITableViewCell.reuseIdentifier(), for: indexPath)

        let genre = SelectGenreViewController.genres[indexPath.row]
        cell.textLabel?.text = genre
        
        cell.accessoryType = myGenres.contains(genre) ? .checkmark : .none

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        
        guard let cell = tableView.cellForRow(at: indexPath) else { return }
        
        let selectedGenre = SelectGenreViewController.genres[indexPath.row]
        
        switch cell.accessoryType {
        case .none:
            cell.accessoryType = .checkmark
            myGenres.append(selectedGenre)
        case .checkmark:
            cell.accessoryType = .none
            
            if let index = myGenres.firstIndex(of: selectedGenre) {
                myGenres.remove(at: index)
            }
            
        default:
            break
        }
    }
    
}
