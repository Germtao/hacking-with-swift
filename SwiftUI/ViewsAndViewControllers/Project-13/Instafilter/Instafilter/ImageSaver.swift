//
//  ImageSaver.swift
//  Instafilter
//
//  Created by QDSG on 2020/9/27.
//

import UIKit

class ImageSaver: NSObject {
    var successHandler: (() -> Void)?
    var failureHandler: ((Error) -> Void)?
    
    func writeToPhotoAlbum(image: UIImage) {
        UIImageWriteToSavedPhotosAlbum(image, self, #selector(saveError), nil)
    }
    
    @objc func saveError(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
        if let error = error {
            failureHandler?(error)
        } else {
            successHandler?()
        }
    }
}
