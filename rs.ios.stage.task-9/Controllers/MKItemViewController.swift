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
        layout.sectionInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        layout.scrollDirection = .vertical
        layout.minimumInteritemSpacing = 20
        
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.register(MKGalleryView.self, forCellWithReuseIdentifier: "galleryCell")
        view.backgroundColor = .white
        //        view.contentInset = UIEdgeInsets(top: 20, left: 20, bottom: 30, right: 20)
        
        view.showsVerticalScrollIndicator = false
        view.showsHorizontalScrollIndicator = false
        
        return view
    }()
    
    lazy var closeButton: UIButton = {
        let button = UIButton(frame: .zero)
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.white.cgColor
        button.layer.cornerRadius = 20
        
        if let image = UIImage(named: "xmark-2.png") {
            button.setImage(image, for: .normal)
        }
        if let image = UIImage(named: "xmark-3.png") {
            button.setImage(image, for: .highlighted)
        }
        
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
        self.configureScrollView()
    }
    
    func configureButton() {
        self.contentView.addSubview(self.closeButton)
        self.closeButton.translatesAutoresizingMaskIntoConstraints = false
        
        self.closeButton.addTarget(self, action: #selector(closeView(sender:)), for: .touchUpInside)
        
        self.closeButton.topAnchor.constraint(equalTo: self.contentView.safeAreaLayoutGuide.topAnchor, constant: 30).isActive = true
        self.closeButton.trailingAnchor.constraint(equalTo: self.contentView.safeAreaLayoutGuide.trailingAnchor, constant: -25).isActive = true
        
        self.closeButton.widthAnchor.constraint(equalToConstant: 40).isActive = true
        self.closeButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
    }
    
    func configureCover() {
        //image
        self.imageView.image = self.image
        self.imageView.contentMode = .scaleAspectFill
        self.imageView.clipsToBounds = true
        self.imageView.layer.borderColor = UIColor.white.cgColor
        self.imageView.layer.borderWidth = 1
        self.imageView.layer.cornerRadius = 10
        
        let layer = CAGradientLayer()
        layer.frame = self.imageView.bounds
        layer.colors = [UIColor.clear.cgColor, UIColor.black.cgColor]
        layer.locations = [0.7, 1.0]
        
        self.imageView.layer.addSublayer(layer)
        
        self.contentView.addSubview(self.imageView)
        
        self.imageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.imageView.topAnchor.constraint(equalTo: self.closeButton.bottomAnchor, constant: 30),
            self.imageView.centerXAnchor.constraint(equalTo: self.contentView.centerXAnchor),
            
            self.imageView.widthAnchor.constraint(equalToConstant: 374),
            self.imageView.heightAnchor.constraint(equalToConstant: 500)
        ])
        
        //text
        let textView = UILabel(frame: .zero)
        textView.textColor = .white
        textView.font = UIFont(name: "Rockwell-Regular", size: 48)
        textView.numberOfLines = 0
        textView.lineBreakMode = .byWordWrapping
        textView.sizeToFit()
        
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
        let typeView = TypeView()
        typeView.translatesAutoresizingMaskIntoConstraints = false
        typeView.layer.borderColor = UIColor.white.cgColor
        typeView.layer.borderWidth = 1
        typeView.layer.cornerRadius = 8
        typeView.textAlignment = .center
        typeView.textColor = .white
        typeView.font = UIFont.init(name: "Rockwell", size: 24)
        typeView.backgroundColor = .black
        typeView.clipsToBounds = true
        typeView.text = self.typeText
        
        let typeTextLabel = UILabel(frame: .zero)
        typeTextLabel.textColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        typeTextLabel.font = UIFont(name: "Rockwell-Regular", size: 24)
        typeTextLabel.text = self.typeText
        
        self.contentView.addSubview(typeView)
        
        NSLayoutConstraint.activate([
            typeView.bottomAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 20),
            typeView.centerXAnchor.constraint(equalTo: imageView.centerXAnchor),
            typeView.heightAnchor.constraint(equalToConstant: 40)
        ])
        
        //lineVIew
        let lineView = UIView()
        lineView.backgroundColor = .white
        self.contentView.addSubview(lineView)
        
        lineView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            lineView.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 58),
            lineView.centerXAnchor.constraint(equalTo: imageView.centerXAnchor),
            lineView.widthAnchor.constraint(equalToConstant: 214),
            lineView.heightAnchor.constraint(equalToConstant: 1)
        ])
    }
    
    func configureTextView() {
        let textView = UILabel(frame: .zero) //PaddingLabel(frame: .zero)
        textView.layer.borderWidth = 1
        textView.layer.borderColor = UIColor.white.cgColor
        textView.layer.cornerRadius = 8
        
        let label = UILabel()
        label.text = self.text
        label.textColor = .white
        label.font = UIFont(name: "Rockwell-Regular", size: 24)
        label.numberOfLines = 0
        
        textView.addSubview(label)
        
        label.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            label.bottomAnchor.constraint(equalTo: textView.bottomAnchor, constant: -30),
            label.leadingAnchor.constraint(equalTo: textView.leadingAnchor, constant: 30),
            label.trailingAnchor.constraint(equalTo: textView.trailingAnchor, constant: -40),
            label.topAnchor.constraint(equalTo: textView.topAnchor, constant: 30)
        ])
        //
        //        textView.textColor = .white
        //        textView.font = UIFont(name: "Rockwell-Regular", size: 24)
        //        textView.numberOfLines = 0
        
        //        textView.text = self.text!
        
        self.contentView.addSubview(textView)
        
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 20).isActive = true
        textView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -20).isActive = true
        textView.topAnchor.constraint(equalTo: self.imageView.bottomAnchor, constant: 238).isActive = true
        textView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -30).isActive = true
    }
    
    func configureScrollView() {
        let scrollView = UIScrollView(frame: .zero)
        self.view.addSubview(scrollView)
        scrollView.addSubview(self.contentView)
        
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: self.view.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            scrollView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor)
        ])
        
        contentView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
            
        ])
        
        //        scrollView.contentSize = contentView.frame.size
    }
    
    func configureGalleryCollectionView() {
        self.contentView.addSubview(galleryCollectionView)
        self.galleryCollectionView.backgroundColor = .black
        
        self.galleryCollectionView.isScrollEnabled = false
        
        self.galleryCollectionView.delegate = self
        self.galleryCollectionView.dataSource = self
        
        NSLayoutConstraint.activate([
            galleryCollectionView.topAnchor.constraint(equalTo: self.imageView.bottomAnchor, constant: 98),
            galleryCollectionView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
            galleryCollectionView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor),
            galleryCollectionView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -30),
            galleryCollectionView.heightAnchor.constraint(equalToConstant: 520 * CGFloat(self.images!.count))
        ])
    }
    
    func configureCollectionView() {
        self.contentView.addSubview(collectionView)
        self.collectionView.backgroundColor = .black
        
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        
        NSLayoutConstraint.activate([
            self.collectionView.topAnchor.constraint(equalTo: self.imageView.bottomAnchor, constant: 96.675),
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
            cell.paths = self.paths!
            cell.duration = self.currentDuration
            cell.currentColor = .red
            cell.delegate = self.parent as? MKMainViewController
            
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "galleryCell", for: indexPath) as! MKGalleryView
            cell.image = images![indexPath.row]
            cell.configureImageCell()
            
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
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        
        let sizeClass = UITraitCollection()

        if self.typeText == "Gallery" {
            if UIDevice.current.orientation.isLandscape {
                if sizeClass.horizontalSizeClass == .unspecified || sizeClass.horizontalSizeClass == .regular {
                    self.galleryCollectionView.heightAnchor.constraint(equalToConstant: CGFloat(520 * round(((Double(self.images!.count))/2.0)))).isActive = true
                }
            } else {
                print("portrait")
            }
        }
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        self.imageView.layer.sublayers![0].frame = self.imageView.bounds
    }
}


