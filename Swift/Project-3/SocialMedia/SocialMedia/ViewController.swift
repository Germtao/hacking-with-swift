//
//  ViewController.swift
//  SocialMedia
//
//  Created by QDSG on 2020/8/25.
//

import UIKit

class ViewController: UITableViewController {
    var pictures = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        dealDataByFileManager()
    }
}

private extension ViewController {
    func setupUI() {
        title = "Social Media"
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    func dealDataByFileManager() {
        let fm = FileManager.default
        guard let path = Bundle.main.resourcePath,
              let items = try? fm.contentsOfDirectory(atPath: path) else { return }
        
        pictures = items.filter { $0.hasPrefix("nssl") }
    }
}

extension ViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pictures.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Picture", for: indexPath)
        cell.textLabel?.text = pictures[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc = storyboard?.instantiateViewController(identifier: "Detail") as? DetailViewController {
            vc.selectedImage = pictures[indexPath.row]
            navigationController?.pushViewController(vc, animated: true)
        }
    }
}

