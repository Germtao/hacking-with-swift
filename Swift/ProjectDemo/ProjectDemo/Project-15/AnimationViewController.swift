//
//  AnimationViewController.swift
//  ProjectDemo
//
//  Created by QDSG on 2021/6/2.
//

import UIKit

class AnimationViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    private var currentAnimation = 0
    
    private lazy var imageView: UIImageView = {
        let imgView = UIImageView(image: UIImage(named: "penguin"))
        imgView.center = CGPoint(x: 300, y: 200)
        view.addSubview(imgView)
        return imgView
    }()
    
    @IBOutlet private weak var tapButton: UIButton!

    @IBAction private func tapped() {
        tapButton.isHidden = true
        
        UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 5, options: []) {
            self.animation()
        } completion: { _ in
            self.tapButton.isHidden = false
        }
        
        currentAnimation += 1
        
        if currentAnimation > 7 {
            currentAnimation = 0
        }
    }
    
    private func animation() {
        switch currentAnimation {
        case 0:
            imageView.transform = CGAffineTransform(scaleX: 2, y: 2)
        case 1:
            imageView.transform = .identity
        case 2:
            imageView.transform = CGAffineTransform(translationX: -256, y: -256)
        case 3:
            imageView.transform = .identity
        case 4:
            imageView.transform = CGAffineTransform(rotationAngle: .pi)
        case 5:
            imageView.transform = .identity
        case 6:
            imageView.alpha = 0.1
            imageView.backgroundColor = .green
        case 7:
            imageView.alpha = 1
            imageView.backgroundColor = .clear
        default:
            break
        }
    }
}
