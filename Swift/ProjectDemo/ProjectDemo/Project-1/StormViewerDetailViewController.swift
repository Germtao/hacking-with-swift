//
//  StormViewerDetailViewController.swift
//  ProjectDemo
//
//  Created by QDSG on 2021/5/28.
//

import UIKit

class StormViewerDetailViewController: UIViewController {
    
    @IBOutlet private weak var imageView: UIImageView!
    
    var selectedImage: String?

    override func viewDidLoad() {
        super.viewDidLoad()

        title = selectedImage
        
        if let imageToLoad = selectedImage {
            imageView.image = UIImage(named: imageToLoad)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationItem.largeTitleDisplayMode = .never
        navigationController?.hidesBarsOnTap = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.hidesBarsOnTap = false
    }

}
