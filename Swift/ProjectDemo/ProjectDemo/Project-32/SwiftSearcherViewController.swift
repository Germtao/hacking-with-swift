//
//  SwiftSearcherViewController.swift
//  ProjectDemo
//
//  Created by QDSG on 2021/6/7.
//

import UIKit
import CoreSpotlight
import MobileCoreServices
import SafariServices

class SwiftSearcherViewController: UITableViewController {
    
    private var projects: [[String]] = [
        ["Project 1: Storm Viewer", "Constants and variables, UITableView, UIImageView, FileManager, storyboards"],
        ["Project 2: Guess the Flag", "@2x and @3x images, asset catalogs, integers, doubles, floats, operators (+= and -=), UIButton, enums, CALayer, UIColor, random numbers, actions, string interpolation, UIAlertController"],
        ["Project 3: Social Media", "UIBarButtonItem, UIActivityViewController, the Social framework, URL"],
        ["Project 4: Easy Browser", "loadView(), WKWebView, delegation, classes and structs, URLRequest, UIToolbar, UIProgressView., key-value observing"],
        ["Project 5: Word Scramble", "Closures, method return values, booleans, NSRange"],
        ["Project 6: Auto Layout", "Get to grips with Auto Layout using practical examples and code"],
        ["Project 7: Whitehouse Petitions", "JSON, Data, UITabBarController"],
        ["Project 8: 7 Swifty Words", "addTarget(), enumerated(), count, index(of:), property observers, range operators."]
    ]
    
    private var favorites: [Int] = []
        
    override func viewDidLoad() {
        super.viewDidLoad()

        let defaults = UserDefaults.standard
        if let saveFavorites = defaults.array(forKey: "favorites") as? [Int] {
            favorites = saveFavorites
        }
        
        tableView.isEditing = true
        tableView.allowsSelectionDuringEditing = true
        
        tableView.register(UITableViewCell.self,
                           forCellReuseIdentifier: UITableViewCell.reuseIdentifier())
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return projects.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: UITableViewCell.reuseIdentifier(), for: indexPath)

        let project = projects[indexPath.row]
        let attributedText = makeAttributedString(title: project[0], subtitle: project[1])
        
        cell.textLabel?.attributedText = attributedText
        
        if favorites.contains(indexPath.row) {
            cell.editingAccessoryType = .checkmark
        } else {
            cell.editingAccessoryType = .none
        }

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        showTutorial(indexPath.row)
    }
    
    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return favorites.contains(indexPath.row) ? .delete : .insert
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        switch editingStyle {
        case .insert:
            favorites.append(indexPath.row)
            index(item: indexPath.row)
        case .delete:
            if let index = favorites.firstIndex(of: indexPath.row) {
                favorites.remove(at: index)
                deindex(item: index)
            }
        default:
            break
        }
        
        UserDefaults.standard.set(favorites, forKey: "favorites")
        
        tableView.reloadRows(at: [indexPath], with: .none)
    }
    
    // MARK: - Private Methods
    
    private func deindex(item: Int) {
        CSSearchableIndex.default().deleteSearchableItems(withIdentifiers: ["\(item)"]) { error in
            if let error = error {
                print("Deindexing error: \(error.localizedDescription)")
            } else {
                print("Search item successfully removed!")
            }
        }
    }
    
    private func index(item: Int) {
        let project = projects[item]
        
        let attributeSet = CSSearchableItemAttributeSet(itemContentType: kUTTypeText as String)
        attributeSet.title = project[0]
        attributeSet.contentDescription = project[1]
        
        let item = CSSearchableItem(uniqueIdentifier: "\(item)", domainIdentifier: "com.hackingwithswift", attributeSet: attributeSet)
        
        CSSearchableIndex.default().indexSearchableItems([item]) { error in
            if let error = error {
                print("Indexing error: \(error.localizedDescription)")
            } else {
                print("Search item successfully indexed!")
            }
        }
    }
    
    private func showTutorial(_ which: Int) {
        guard let url = URL(string: "https://www.hackingwithswift.com/read/\(which + 1)") else { return }
        
        let config = SFSafariViewController.Configuration()
        config.entersReaderIfAvailable = true
        
        let vc = SFSafariViewController(url: url, configuration: config)
        present(vc, animated: true)
    }
    
    private func makeAttributedString(title: String, subtitle: String) -> NSAttributedString {
        let titleAttributes = [
            NSAttributedString.Key.font: UIFont.preferredFont(forTextStyle: .headline),
            NSAttributedString.Key.foregroundColor: UIColor.purple
        ]
        let subtitleAttributes = [
            NSAttributedString.Key.font: UIFont.preferredFont(forTextStyle: .subheadline)
        ]
        
        let titleAttrStr = NSMutableAttributedString(string: "\(title)\n", attributes: titleAttributes)
        let subtitleAttrStr = NSAttributedString(string: subtitle, attributes: subtitleAttributes)
        
        titleAttrStr.append(subtitleAttrStr)
        
        return titleAttrStr
    }
}

