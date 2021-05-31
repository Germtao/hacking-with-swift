//
//  AutoLayoutViewController.swift
//  ProjectDemo
//
//  Created by QDSG on 2021/5/31.
//

import UIKit

class AutoLayoutViewController: UITableViewController {
    
    private var titles: [String] = ["AutoLayout - 1", "AutoLayout - 2"]

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.tableFooterView = UIView()
        tableView.register(UITableViewCell.self,
                           forCellReuseIdentifier: UITableViewCell.reuseIdentifier())
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titles.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: UITableViewCell.reuseIdentifier(), for: indexPath)
        cell.textLabel?.text = titles[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0: autoLayout1(titles[indexPath.row])
        case 1: autoLayout2(titles[indexPath.row])
        default: break
        }
    }
    
    private func autoLayout1(_ title: String) {
        let vc = AutoLayout1ViewController()
        vc.title = title
        navigationController?.pushViewController(vc, animated: true)
    }
    
    private func autoLayout2(_ title: String) {
        let vc = AutoLayout2ViewController()
        vc.title = title
        navigationController?.pushViewController(vc, animated: true)
    }
}
