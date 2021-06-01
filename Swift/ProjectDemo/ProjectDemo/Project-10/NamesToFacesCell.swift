//
//  NamesToFacesCell.swift
//  ProjectDemo
//
//  Created by QDSG on 2021/6/1.
//

import UIKit

class NamesToFacesCell: UICollectionViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        layer.cornerRadius = 7
    }
    
    func update(with model: NamesToFaces) {
        titleLabel.text = model.name
        let imagePath = getDocumentsDirectory().appendingPathComponent(model.image)
        imageView.image = UIImage(contentsOfFile: imagePath.path)
    }
    
    @IBOutlet private weak var imageView: UIImageView! {
        didSet {
            imageView.layer.cornerRadius = 3
            imageView.layer.borderWidth = 2
            imageView.layer.borderColor = UIColor.black.withAlphaComponent(0.3).cgColor
        }
    }
    @IBOutlet private weak var titleLabel: UILabel!
}
