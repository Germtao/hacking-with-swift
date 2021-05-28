//
//  StormViewerViewController.swift
//  ProjectDemo
//
//  Created by QDSG on 2021/5/28.
//

import UIKit

class StormViewerViewController: UITableViewController {
    
    private var dataSource: [[String]] = [] {
        didSet { tableView.reloadData() }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white

        title = "Storm Viewer"
        
        tableView.tableFooterView = UIView()
        tableView.register(UITableViewCell.self,
                           forCellReuseIdentifier: "StormViewer")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.prefersLargeTitles = true
        
        setDataSource()
    }
    
    private func setDataSource() {
        var array = [[String]]()
        array.append(pictures())
        array.append(descriptions())
        dataSource = array
    }
    
    private func pictures() -> [String] {
        let manager = FileManager.default
        guard let path = Bundle.main.resourcePath,
              let files = try? manager.contentsOfDirectory(atPath: path) else { return [] }
        
        return files.filter { $0.hasPrefix("nssl") }.sorted()
    }
    
    private func descriptions() -> [String] {
        return [
            "1、使用 FileManager 列出图片",
            "2、设计我们的界面，并建立详情界面",
            "3、使用 UIImage 加载图片",
            "4、最终调整：hidesBarsOnTap 和 大标题"
        ]
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return dataSource.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource[section].count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "StormViewer", for: indexPath)
        cell.textLabel?.text = dataSource[indexPath.section][indexPath.row]
        cell.textLabel?.textColor = indexPath.section == 0 ? .darkText : .darkGray
        cell.selectionStyle = indexPath.section == 0 ? .default : .none
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard indexPath.section == 0 else { return }
        
        let storyboard = UIStoryboard(name: "StormViewer", bundle: nil)
        guard let vc = storyboard.instantiateViewController(identifier: "StormViewerDetail") as? StormViewerDetailViewController else { return }
        vc.selectedImage = dataSource[0][indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return section == 0 ? "图片" : "知识点"
    }
}
