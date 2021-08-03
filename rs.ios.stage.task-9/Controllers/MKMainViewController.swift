//
//  MKMainViewController.swift
//  rs.ios.stage.task-9
//
//  Created by dev on 30.07.21.
//

import UIKit

class MKMainViewController: UIViewController {
    //MARK: Properties
    var itemViewController: MKItemViewController?
    
    var data = FillingData.data
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 20, bottom: 50, right: 20)
        layout.minimumInteritemSpacing = 16
        layout.minimumLineSpacing = 30
        
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.register(MKCollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        view.backgroundColor = .white
        
        view.showsVerticalScrollIndicator = false
        view.showsHorizontalScrollIndicator = false
        
        return view
    }()
    
    //MARK: Controller methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureCollectionView()
    }
    
    //MARK: UICollectionView methods
    
    func configureCollectionView() {
        self.view.backgroundColor = .white
        self.view.addSubview(collectionView)
        
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        
        self.collectionView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        self.collectionView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        self.collectionView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        self.collectionView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        
    }
}

extension MKMainViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = self.collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! MKCollectionViewCell
        
        switch data[indexPath.row] {
        case .story(let item):
            cell.image = item.coverImage
            cell.nameText = item.title
            cell.typeText = item.type
            
            cell.drawingPath = item.paths
            cell.text = item.text
            cell.delegate = self
        case .gallery(let item):
            cell.image = item.coverImage
            cell.nameText = item.title
            cell.typeText = item.type
            
            cell.images = item.images
            cell.delegate = self
        }
        cell.configureCell()

        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 179, height: 220)
    }
}


