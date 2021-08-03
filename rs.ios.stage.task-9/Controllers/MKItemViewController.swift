//
//  MKStoryViewController.swift
//  rs.ios.stage.task-9
//
//  Created by dev on 31.07.21.
//

import UIKit

class MKItemViewController: UIViewController {
    //MARK: Properties
    var image: UIImage?
    var itemTitle: String?
    var typeText: String?
    var text: String?
    var paths: [CGPath]?
    var images: [UIImage]?
    
    var imageView = UIImageView()
    
    var arrayOfDrawings: Array<MKDrawingView>?
    
    var currentDuration = 3
    
    var contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 50, bottom: 0, right: 0)
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 100
        
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.register(MKDrawingView.self, forCellWithReuseIdentifier: "drawingCell")
        view.backgroundColor = .white
        
        view.showsVerticalScrollIndicator = false
        view.showsHorizontalScrollIndicator = false
        
        return view
    }()
    
    lazy var galleryCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 20
        
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.register(MKGalleryView.self, forCellWithReuseIdentifier: "galleryCell")
        view.backgroundColor = .white
        
        view.showsVerticalScrollIndicator = false
        view.showsHorizontalScrollIndicator = false
        
        return view
    }()
    
    lazy var closeButton: UIButton = {
        let button = UIButton(frame: .zero)
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.white.cgColor
        button.layer.cornerRadius = 20
        
        button.imageView?.image = UIImage(systemName: "xmark")
        button.imageView?.centerXAnchor.constraint(equalTo: button.centerXAnchor).isActive = true
        button.imageView?.centerYAnchor.constraint(equalTo: button.centerYAnchor).isActive = true
        
        button.translatesAutoresizingMaskIntoConstraints = false
        button.imageView?.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    //MARK: viewWillAppear
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.setup()
        
        print("story controller invoked")
    }
    
    //MARK: Configuration methods
    func setup() {
        self.view.backgroundColor = .black
        
        switch self.typeText {
        case "Story":
            self.configureStory()
        case "Gallery":
            self.configureGallery()
        default:
            print("unrecognised")
            break
        }
    }
    
    func configureStory() {
        self.configureScrollView()
        self.configureButton()
        self.configureCover()
        self.configureTextView()
        self.configureCollectionView()
    }
    
    func configureGallery() {
        self.configureButton()
        self.configureCover()
        self.configureGalleryCollectionView()
    }
    
    func configureButton() {
        //        self.scrollView.subviews.first!.addSubview(self.closeButton)
        self.contentView.addSubview(self.closeButton)
        
        self.closeButton.addTarget(self, action: #selector(closeView(sender:)), for: .touchUpInside)
        
        self.closeButton.topAnchor.constraint(equalTo: self.contentView.safeAreaLayoutGuide.topAnchor, constant: 30).isActive = true
        self.closeButton.trailingAnchor.constraint(equalTo: self.contentView.safeAreaLayoutGuide.trailingAnchor, constant: -25).isActive = true
        
        self.closeButton.widthAnchor.constraint(equalToConstant: 40).isActive = true
        self.closeButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
    }
    
    func configureCover() {
        //image
        self.imageView.image = self.image
        self.imageView.translatesAutoresizingMaskIntoConstraints = false
        self.imageView.contentMode = .scaleAspectFill
        self.imageView.clipsToBounds = true
        self.imageView.layer.borderColor = UIColor.white.cgColor
        self.imageView.layer.borderWidth = 1
        self.imageView.layer.cornerRadius = 10
        
        let layer0 = CAGradientLayer()
        layer0.colors = [
            UIColor(red: 0, green: 0, blue: 0, alpha: 0).cgColor,
            UIColor(red: 0, green: 0, blue: 0, alpha: 1).cgColor
        ]
        layer0.locations = [0.51, 1]
        layer0.startPoint = CGPoint(x: 0.25, y: 0.5)
        layer0.endPoint = CGPoint(x: 0.85, y: 0.5)
        layer0.transform = CATransform3DMakeAffineTransform(CGAffineTransform(a: 0, b: 1, c: -1, d: 0, tx: 1, ty: 0))
        layer0.bounds = self.imageView.bounds.insetBy(dx: -0.5*self.imageView.bounds.size.width, dy: -0.5*self.imageView.bounds.size.height)
        layer0.position = self.imageView.center
        
        self.imageView.layer.addSublayer(layer0)
        
        //        self.scrollView.subviews.first!.addSubview(imageView)
        self.contentView.addSubview(self.imageView)
        
        NSLayoutConstraint.activate([
            self.imageView.topAnchor.constraint(equalTo: self.closeButton.bottomAnchor, constant: 30),
            self.imageView.centerXAnchor.constraint(equalTo: self.contentView.centerXAnchor),
            
            self.imageView.widthAnchor.constraint(equalToConstant: 374),
            self.self.imageView.heightAnchor.constraint(equalToConstant: 500)
        ])
        
        //text
        let textView = UILabel(frame: .zero)
        textView.textColor = .white
        textView.font = UIFont(name: "Rockwell-Regular", size: 48)
        textView.numberOfLines = 0
        textView.lineBreakMode = .byWordWrapping
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 1.2
        
        if (self.itemTitle?.last == "\n") {
            self.itemTitle?.removeLast()
        }
        textView.attributedText = NSAttributedString(string: self.itemTitle!, attributes: [NSAttributedString.Key.paragraphStyle: paragraphStyle])
        
        imageView.addSubview(textView)
        
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.widthAnchor.constraint(equalToConstant: 314).isActive = true
        textView.leadingAnchor.constraint(equalTo: imageView.leadingAnchor, constant: 30).isActive = true
        textView.bottomAnchor.constraint(equalTo: imageView.bottomAnchor, constant: -55).isActive = true
        
        //Type label
        let typeView = UILabel()
        typeView.backgroundColor = .black
        typeView.clipsToBounds = true
        typeView.layer.cornerRadius = 8
        typeView.layer.borderWidth = 1
        typeView.layer.borderColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1).cgColor
        
        let typeTextLabel = UILabel(frame: .zero)
        typeTextLabel.textColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        typeTextLabel.font = UIFont(name: "Rockwell-Regular", size: 24)
        typeTextLabel.text = self.typeText
        
        typeView.addSubview(typeTextLabel)
        
        typeTextLabel.translatesAutoresizingMaskIntoConstraints = false
        typeTextLabel.heightAnchor.constraint(equalToConstant: 29).isActive = true
        typeTextLabel.leadingAnchor.constraint(equalTo: typeView.leadingAnchor, constant: 30).isActive = true
        typeTextLabel.topAnchor.constraint(equalTo: typeView.topAnchor, constant: 8).isActive = true
        typeTextLabel.trailingAnchor.constraint(equalTo: typeView.trailingAnchor, constant: -30).isActive = true
        
        //        self.scrollView.subviews.first!.addSubview(typeView)
        //        self.scrollView.subviews.first!.bringSubviewToFront(typeView)
        self.contentView.addSubview(typeView)
        
        typeView.translatesAutoresizingMaskIntoConstraints = false
        typeView.topAnchor.constraint(equalTo: imageView.topAnchor, constant: 479).isActive = true
        typeView.centerXAnchor.constraint(equalTo: imageView.centerXAnchor).isActive = true
        typeView.widthAnchor.constraint(equalToConstant: 122).isActive = true
        typeView.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        //lineVIew
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.frame = CGRect(x: 100, y: 658, width: 214, height: 0)
        view.backgroundColor = .white
        
        //        NSLayoutConstraint.activate([
        //            view.topAnchor.constraint(equalTo: imageView.topAnchor, constant: 658),
        //            view.centerXAnchor.constraint(equalTo: imageView.centerXAnchor)
        //        ])
    }
    
    func configureTextView() {
        let textView = UILabel(frame: .zero)
        textView.layer.borderWidth = 1
        textView.layer.borderColor = UIColor.white.cgColor
        textView.layer.cornerRadius = 8
        
        let text = UILabel(frame: .zero)
        text.textColor = .white
        text.font = UIFont(name: "Rockwell-Regular", size: 24)
        text.numberOfLines = 0
        text.lineBreakMode = .byWordWrapping
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 1.2
        text.attributedText = NSAttributedString(string: self.text!, attributes: [NSAttributedString.Key.paragraphStyle: paragraphStyle])
        
        textView.addSubview(text)
        
        text.translatesAutoresizingMaskIntoConstraints = false
        text.widthAnchor.constraint(equalToConstant: 304).isActive = true
        text.leadingAnchor.constraint(equalTo: textView.leadingAnchor, constant: 30).isActive = true
        text.topAnchor.constraint(equalTo: textView.topAnchor, constant: 30).isActive = true
        
        //        self.scrollView.subviews.first!.addSubview(textView)
        self.contentView.addSubview(textView)
        
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.widthAnchor.constraint(equalToConstant: 374).isActive = true
        textView.heightAnchor.constraint(equalToConstant: 727).isActive = true
        textView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 20).isActive = true
        textView.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 838).isActive = true
//        textView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -30).isActive = true
    }
    
    func configureScrollView() {
        let scrollView = UIScrollView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(scrollView)
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: self.view.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: self.view.topAnchor),
            scrollView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor)
        ])
        
        scrollView.addSubview(self.contentView)
        
        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor)
        ])
    }
    
    func configureGalleryCollectionView() {
        self.contentView.addSubview(galleryCollectionView)
        self.galleryCollectionView.backgroundColor = .red
        
        self.galleryCollectionView.isScrollEnabled = false
        
        self.galleryCollectionView.delegate = self
        self.galleryCollectionView.dataSource = self
        
        NSLayoutConstraint.activate([
            self.collectionView.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 698),
            self.collectionView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 20),
            self.collectionView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -20),
            self.collectionView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -20)
        ])
    }
    
    func configureCollectionView() {
        //        self.scrollView.subviews.first!.addSubview(collectionView)
        self.contentView.addSubview(collectionView)
        self.collectionView.backgroundColor = .red
        
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        
        NSLayoutConstraint.activate([
            self.collectionView.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 716),
            self.collectionView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 36),
            self.collectionView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -34),
            self.collectionView.heightAnchor.constraint(equalToConstant: 100)
        ])
    }
    
    @objc func closeView(sender: UIButton) {
        self.parent?.tabBarController?.tabBar.isHidden = false
        self.view.removeFromSuperview()
        self.removeFromParent()
    }
    
    
}

//MARK: Collection view stuff
extension MKItemViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView .isEqual(self.galleryCollectionView) {
            return (images?.count)!
        } else {
            return (paths?.count)!
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView.isEqual(self.collectionView) {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "drawingCell", for: indexPath) as! MKDrawingView
            cell.currentDrawing = indexPath.row
            cell.delegate = self.parent as? MKMainViewController
            
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "galleryCell", for: indexPath) as! MKGalleryView
            cell.image = images![indexPath.row]
            
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView.isEqual(self.galleryCollectionView) {
            return CGSize(width: 374, height: 511)
        } else {
            return CGSize(width: 73, height: 60.43)
        }
    }
    
}
