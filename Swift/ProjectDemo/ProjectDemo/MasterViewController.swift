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
                   description: "在学习 闭包 和 布尔值 的同时创建一个字谜游戏。"),
            Master(title: "Project 6: Auto Layout",
                   subtitle: "NSLayoutConstraint，Visual Format Language(视觉格式语言)，布局锚点",
                   description: "使用实际示例和代码来掌握 Auto Layout!"),
            Master(title: "Project 7: Whitehouse Petitions",
                   subtitle: "JSON, Data, UITabBarController",
                   description: "制作一个使用 JSON 和 TabBar 解析的 Whitehouse Petitions 的 App。"),
            Master(title: "Project 8: 7 Swifty Words",
                   subtitle: "addTarget()、enumerated()、count()、index(of:)、joined()、属性观察器、范围运算符",
                   description: "构建一个猜词游戏并一劳永逸地掌握 String。"),
            Master(title: "Project 9: Grand Central Dispatch",
                   subtitle: "DispatchQueue, perform(inBackground:)",
                   description: "了解如何使用 GCD 在后台运行复杂的任务。"),
            Master(title: "Project 10: Names to Faces",
                   subtitle: "UICollectionView、UIImagePickerController、UUID、类",
                   description: "开始使用 UICollectionView 和照片库。"),
            Master(title: "Project 11: Pachinko",
                   subtitle: "SpriteKit、物理、混合模式、弧度、CGFloat、NSKeyedUnarchiver",
                   description: "深入 SpriteKit，尝试快速 2D 游戏。"),
            Master(title: "Project 12: UserDefaults",
                   subtitle: "UserDefaults, NSCoding, Codable, NSKeyedArchiver",
                   description: "了解如何保存用户设置和数据以备后用。"),
            Master(title: "Project 13: Instafilter",
                   subtitle: "Core Image, UISlider, 写入图片库",
                   description: "使用 Core Image 滤镜和 UISlider 制作照片处理程序。"),
            Master(title: "Project 14: Whack-a-Penguin",
                   subtitle: "SKCropNode、SKTexture、asyncAfter()",
                   description: "使用 SKCropNode 和少量的 Grand Central Dispatch 构建游戏。"),
            Master(title: "Project 15: Animation",
                   subtitle: "Core Animation, CGAffineTransform",
                   description: "通过动画使您的界面栩栩如生，并同时满足 switch/case。")
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
        case 5:    autoLayout()
        case 6, 8: whitehousePetition()
        case 7:    swiftyWords()
        case 9, 11: namesToFaces()
        case 10:   pachinko()
        case 12:   instafilter()
        case 13:   whackAPenguin()
        case 14:   animation()
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
    
    private func autoLayout() {
        let vc = AutoLayoutViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    private func whitehousePetition() {
        let storyboard = UIStoryboard(name: "Whitehouse", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "Whitehouse")
        navigationController?.pushViewController(vc, animated: true)
    }
    
    private func swiftyWords() {
        let vc = SwiftyWordsViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    private func namesToFaces() {
        let vc = NamesToFacesViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    private func pachinko() {
        let vc = GameViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    private func instafilter() {
        let vc = InstafilterViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    private func whackAPenguin() {
        let vc = WhackGameViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    private func animation() {
        let vc = AnimationViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
}

