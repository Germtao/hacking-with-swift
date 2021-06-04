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
                   description: "通过动画使您的界面栩栩如生，并同时满足 switch/case。"),
            Master(title: "Project 16: Capital Cities",
                   subtitle: "MKMapView、MKAnnotation、MKPinAnnotationView、CLLocationCoordinate2D",
                   description: "在您了解 MKMapView 和注释的同时，向用户传授地理知识。"),
            Master(title: "Project 17: Space Race",
                   subtitle: "每像素碰撞检测、推进粒子系统、线性和角度阻尼",
                   description: "在您了解每像素碰撞检测的同时躲避空间碎片。"),
            Master(title: "Project 18: Debugging",
                   subtitle: "print()、assert()、断点和查看调试",
                   description: "每个人迟早都会遇到问题，所以学会发现和解决问题是一项重要的技能。"),
            Master(title: "Project 19: JavaScript Injection",
                   subtitle: "Safari extensions, UITextView, NotificationCenter",
                   description: "为 JavaScript 开发人员使用一个很酷的功能扩展 Safari。"),
            Master(title: "Project 20: Fireworks Night",
                   subtitle: "Timer, follow(path:), sprite color blending, shake gestures",
                   description: "了解计时器和颜色混合，同时让事情变得精彩！"),
            Master(title: "Project 21: Local Notifications",
                   subtitle: "UNUserNotificationCenter、UNNotificationRequest、UNMutableNotificationContent、UNCalendarNotificationTrigger 和 UNTimeIntervalNotificationTrigger",
                   description: "即使您的应用未运行，也可以发送提醒、提示和警报。"),
            Master(title: "Project 22: Detect-a-Beacon",
                   subtitle: "CLLocationManager、CLBeaconRegion、CLProximity",
                   description: "学习使用我们的第一个物理设备项目查找和范围 iBeacon。"),
            Master(title: "Project 23: Swifty Ninja",
                   subtitle: "SKShapeNode、AVAudioPlayer、UIBezierPath、自定义枚举",
                   description: "学习在 SpriteKit 中绘制形状，同时制作有趣且紧张的切片游戏。"),
            Master(title: "Project 25: Selfie Share",
                   subtitle: "多点连接框架(Multipeer Connectivity Framework)",
                   description: "制作多人照片共享应用程序。"),
            Master(title: "Project 26: Marble Maze",
                   subtitle: "Core Motion、碰撞位掩码、数组反转、编译器指令",
                   description: "通过在涡旋迷宫周围操纵球来响应设备倾斜。"),
            Master(title: "Project 27: Core Graphics",
                   subtitle: "Core Graphics",
                   description: "使用 Apple 的高速绘图框架绘制 2D 形状。"),
            Master(title: "Project 28: Secret Swift",
                   subtitle: "Touch ID 和 Face ID、设备钥匙串",
                   description: "使用设备钥匙串和触控 ID 安全地保存用户数据。"),
            Master(title: "Project 30: Instruments",
                   subtitle: "Profiling, shadows, image caching",
                   description: "成为一名漏洞侦探并追踪丢失的内存、缓慢的绘图等等。")
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
        case 15:   mkMapView()
        case 16:   spaceRaceGame()
        case 17:   debugging()
        case 18:   javascriptInjection()
        case 19:   fireworksNight()
        case 20:   localNotification()
        case 21:   location()
        case 22:   swiftyNinja()
        case 23:   selfieShare()
        case 24:   marbleMaze()
        case 25:   coreGraphics()
        case 26:   secretSwift()
        case 27:   instruments()
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
    
    private func mkMapView() {
        let vc = MapViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    private func spaceRaceGame() {
        let vc = SpaceRaceViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    private func debugging() {
        print("I'm inside the viewDidLoad() method!")
        print(1, 2, 3, 4, 5, separator: "-")

        assert(1 == 1, "Maths failure!")

        for i in 1 ... 100 {
            print("Got number \(i)")
        }
    }
    
    private func javascriptInjection() {
        let vc = JavascriptInjectionViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    private func fireworksNight() {
        let vc = FireworksGameViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    private func localNotification() {
        let vc = LocalNotificationViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    private func location() {
        let vc = LocationViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    private func swiftyNinja() {
        let vc = SwiftyNinjaViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    private func selfieShare() {
        let vc = SelfieShareViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    private func marbleMaze() {
        let vc = MarbleMazeViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    private func coreGraphics() {
        let vc = CoreGraphicsViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    private func secretSwift() {
        let vc = SecretSwiftViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    private func instruments() {
        let vc = SelectionViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
}

