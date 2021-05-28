//
//  MasterViewController.swift
//  ProjectDemo
//
//  Created by QDSG on 2021/5/28.
//

import UIKit

class MasterViewController: UIViewController {
    
    private var dataSource: [Master] {
        return [
            Master(title: "Project 1: Storm Viewer",
                   subtitle: "常量和变量, UITableView, UIImageView, FileManager, Storyboards",
                   description: "通过制作图像查看器应用并学习关键概念，开始在Swift中进行编码。")
        ]
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.prefersLargeTitles = false
    }

    @IBOutlet private weak var tableView: UITableView! {
        didSet {
            tableView.estimatedRowHeight = 100
            tableView.rowHeight = UITableView.automaticDimension
            tableView.register(MasterViewCell.nibForCell(),
                               forCellReuseIdentifier: MasterViewCell.reuseIdentifier())
        }
    }
}

extension MasterViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MasterViewCell.reuseIdentifier(),
                                                 for: indexPath) as! MasterViewCell
        cell.update(with: dataSource[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        switch indexPath.row {
        case 0: stormViewer()
        default:
            break
        }
    }
}

extension MasterViewController {
    private func stormViewer() {
        let vc = StormViewerViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
}
