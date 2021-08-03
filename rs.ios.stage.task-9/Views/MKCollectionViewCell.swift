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
        
        let imageView = UIImageView(frame: CGRect(x: 8, y: 10, width: 163, height: 200))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.borderColor = UIColor.black.cgColor
        imageView.layer.borderWidth = 1
        imageView.layer.cornerRadius = 10
        
        imageView.image = image
        
        let layer0 = CAGradientLayer()
        layer0.colors = [
          UIColor(red: 0, green: 0, blue: 0, alpha: 0).cgColor,
          UIColor(red: 0, green: 0, blue: 0, alpha: 1).cgColor
        ]
        layer0.locations = [0.74, 1]
        layer0.startPoint = CGPoint(x: 0.25, y: 0.5)
        layer0.endPoint = CGPoint(x: 0.75, y: 0.5)
        layer0.transform = CATransform3DMakeAffineTransform(CGAffineTransform(a: 0, b: 1, c: -1, d: 0, tx: 1, ty: 0))
        layer0.bounds = imageView.bounds.insetBy(dx: -0.5*imageView.bounds.size.width, dy: -0.5*imageView.bounds.size.height)
        layer0.position = imageView.center
        
        imageView.layer.addSublayer(layer0)
        
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
