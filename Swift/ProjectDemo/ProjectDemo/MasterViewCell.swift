//
//  MasterViewCell.swift
//  ProjectDemo
//
//  Created by QDSG on 2021/5/28.
//

import UIKit

class MasterViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func update(with model: Master) {
        titleLabel.text = model.title
        subtitleLabel.text = model.subtitle
        descLabel.text = model.description
    }
    
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var subtitleLabel: UILabel!
    @IBOutlet private weak var descLabel: UILabel!
}
