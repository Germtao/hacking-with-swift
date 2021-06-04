//
//  ImageViewController.swift
//  ProjectDemo
//
//  Created by QDSG on 2021/6/4.
//

import UIKit

class ImageViewController: UIViewController {
    
    var owner: SelectionViewController!
    var image: String!
    var animTimer: Timer?
    
    var imageView: UIImageView!
    
    override func loadView() {
        super.loadView()
        
        view.backgroundColor = .black
        
        imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.alpha = 0
        view.addSubview(imageView)
        
        imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        imageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        imageView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        
        animTimer = Timer.scheduledTimer(withTimeInterval: 5, repeats: true, block: animation)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        title = image.replacingOccurrences(of: "-Large.jpg", with: "")
        
        guard let original = UIImage(named: image) else { return }
        
        let renderer = UIGraphicsImageRenderer(size: original.size)
        
        let rounded = renderer.image { ctx in
            ctx.cgContext.addEllipse(in: CGRect(origin: .zero, size: original.size))
            ctx.cgContext.closePath()
            
            original.draw(at: .zero)
        }
        
        imageView.image = rounded
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        imageView.alpha = 0
        
        UIView.animate(withDuration: 3) {
            self.imageView.alpha = 1
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let defaults = UserDefaults.standard
        var currentVal = defaults.integer(forKey: image)
        currentVal += 1
        
        defaults.set(currentVal, forKey: image)
        
        owner.dirty = true
    }
    
    private func animation(_ timer: Timer) {
        imageView.transform = .identity
        UIView.animate(withDuration: 3) {
            self.imageView.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
        }
    }

}
