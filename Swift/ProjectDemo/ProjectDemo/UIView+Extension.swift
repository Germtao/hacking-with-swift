//
//  UIView+Extension.swift
//  ProjectDemo
//
//  Created by QDSG on 2021/5/28.
//

import UIKit

extension UIView {
    static func nibForCell() -> UINib {
        return UINib(nibName: String(describing: self), bundle: nil)
    }
    
    static func reuseIdentifier() -> String {
        return String(describing: self) + "reuseIdentifier"
    }
}
