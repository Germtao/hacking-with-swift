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
                   description: "通过制作图像查看器应用并学习关键概念，开始在Swift中进行编码。"),
            Master(title: "Project 2: Guess the Flag",
                   subtitle: "Asset catalogs, UIButton, CALayer, UIColor, UIAlertController",
                   description: "使用 UIKit 制作游戏，并了解整数，按钮，颜色和Actions。"),
            Master(title: "Project 3: Social Media",
                   subtitle: "UIBarButtonItem, UIActivityViewController, URL",
                   description: "通过修改 Project 1，让用户共享到Facebook和Twitter。"),
            Master(title: "Project 4: Easy Browser",
                   subtitle: "loadView(), WKWebView, URLRequest, UIToolbar, UIProgressView, key-value observing",
                   description: "嵌入Web Kit并了解有关委托，KVO，类和UIToolbar的信息。"),
            Master(title: "Project 5: Word Scramble",
                   subtitle: "闭包、方法返回值、布尔值、NSRange",
                   description: "在学习 闭包 和 布尔值 的同时创建一个字谜游戏。")
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
        case 0, 2: stormViewer()
        case 1:    guessTheFlag()
        case 3:    easyBrowser()
        case 4:    wordScramble()
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
    
    private func guessTheFlag() {
        let vc = GuessTheFlagViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    private func easyBrowser() {
        let vc = WebViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    private func wordScramble() {
        let vc = WordScrambleViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
}

