//
//  MKGalleryView.swift
//  rs.ios.stage.task-9
//
//  Created by dev on 3.08.21.
//

import UIKit

class MKGalleryView: UICollectionViewCell {
    
    var image: UIImage?

    func configureImageCell() {
        let imageView = UIImageView()
        imageView.image = image
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 8
        imageView.clipsToBounds = true
        
        self.layer.cornerRadius = 8
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.white.cgColor
        
        self.addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate ([
            imageView.topAnchor.constraint(equalTo: self.topAnchor, constant:10),
            imageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant:10),
            imageView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant:-10),
            imageView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant:-10)
        ])
    }

}

