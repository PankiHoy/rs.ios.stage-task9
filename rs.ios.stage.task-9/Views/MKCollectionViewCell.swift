//
//  MKView.swift
//  rs.ios.stage.task-9
//
//  Created by dev on 31.07.21.
//

import UIKit

class MKCollectionViewCell: UICollectionViewCell {
    var delegate: MKMainViewController?
    
    var image: UIImage?
    var text: String?
    var nameText: String?
    var typeText: String?
    
    var drawingPath: Array<CGPath>?
    var images: Array<UIImage>?
    
    var imageView: UIImageView!

    override init(frame: CGRect) {
        super.init(frame: frame)
//        let tapGestureRecognizer = UITapGestureRecognizer(target: self.delegate, action: #selector(viewTouched(sender:)))
//        self.addGestureRecognizer(tapGestureRecognizer)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureCell() {
        self.backgroundColor = .white
        self.layer.cornerRadius = 18
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.black.cgColor
        
        self.frame.size = CGSize(width: 179, height: 220)
        
        self.imageView = UIImageView(frame: CGRect(x: 8, y: 10, width: 163, height: 200))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.borderColor = UIColor.black.cgColor
        imageView.layer.borderWidth = 1
        imageView.layer.cornerRadius = 10
        
        imageView.image = image
        
        let layer = CAGradientLayer()
        layer.frame = imageView.bounds
        layer.colors = [UIColor.clear.cgColor, UIColor.black.cgColor]
        layer.locations = [0.7, 1.0]
        
        imageView.layer.addSublayer(layer)
        
        let nameTextView = UILabel()
        nameTextView.frame = CGRect(x: 10, y: 151, width: 138, height: 19)
        nameTextView.text = nameText
        nameTextView.font = UIFont(name: "Rockwell", size: 16)
        nameTextView.textColor = .white
        
        let typeTextView = UILabel()
        typeTextView.frame = CGRect(x: 10, y: 173, width: 138, height: 14)
        typeTextView.text = typeText
        typeTextView.font = UIFont(name: "Rockwell-Regular", size: 12)
        typeTextView.textColor = UIColor(red: 0.712, green: 0.712, blue: 0.712, alpha: 1)
        
        imageView.addSubview(nameTextView)
        imageView.addSubview(typeTextView)
        
        self.addSubview(imageView)
        
        imageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 10).isActive = true
        imageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 8).isActive = true
        imageView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -8).isActive = true
        imageView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10).isActive = true
        
        typeTextView.topAnchor.constraint(equalTo: imageView.topAnchor, constant: 173).isActive = true
        typeTextView.leadingAnchor.constraint(equalTo: imageView.leadingAnchor, constant: 10).isActive = true
        typeTextView.trailingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: -15).isActive = true
        typeTextView.bottomAnchor.constraint(equalTo: imageView.bottomAnchor, constant: -13).isActive = true

        nameTextView.topAnchor.constraint(equalTo: imageView.topAnchor, constant: 151).isActive = true
        nameTextView.leadingAnchor.constraint(equalTo: imageView.leadingAnchor, constant: 10).isActive = true
        nameTextView.trailingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: -15).isActive = true
        nameTextView.bottomAnchor.constraint(equalTo: imageView.bottomAnchor, constant: -30).isActive = true
        
        self.makeButtonOnTopOfTheView()
    }
    
    func addContentController(content: UIViewController) {
        self.delegate?.addChild(content)
        self.delegate?.view.addSubview(content.view)
        content.view.frame = (self.delegate?.view.frame)!;
        content.didMove(toParent: self.delegate)
        self.delegate?.tabBarController?.tabBar.isHidden = true
    }

    @objc func viewTouched(sender: UIView) {
        switch self.typeText {
        case "Story":
            self.delegate?.itemViewController = MKItemViewController()
            let itemController = self.delegate?.itemViewController
            itemController?.image = image
            itemController?.itemTitle = nameText
            itemController?.typeText = typeText
            
            itemController?.paths = drawingPath
            itemController?.text = text
            self.addContentController(content: itemController!)
        case "Gallery":
            self.delegate?.itemViewController = MKItemViewController()
            let itemController = self.delegate?.itemViewController
            itemController?.image = image
            itemController?.itemTitle = nameText
            itemController?.typeText = typeText
            
            itemController?.images = images
            self.addContentController(content: itemController!)
        default:
            break
        }
    }
    
    func makeButtonOnTopOfTheView() {
        let button = UIButton(frame: self.bounds)
        button.addTarget(self, action: #selector(viewTouched(sender:)), for: UIControl.Event.touchUpInside)
        
        self.addSubview(button)
    }
}
