//
//  MKGalleryView.swift
//  rs.ios.stage.task-9
//
//  Created by dev on 3.08.21.
//

import UIKit

class MKGalleryView: UICollectionViewCell {
    
    var image: UIImage?

    override func didMoveToSuperview() {
        
        
    }
    
    func configureImageCell() {
        let imageView = UIImageView(image: image)
        imageView.layer.cornerRadius = 4
        
        self.layer.cornerRadius = 8
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.white.cgColor
        
        self.addSubview(imageView)
        
        NSLayoutConstraint.activate([
            imageView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            imageView.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        ])
    }

}
