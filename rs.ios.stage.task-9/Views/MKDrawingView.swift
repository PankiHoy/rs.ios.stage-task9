//
//  MKDrawingView.swift
//  rs.ios.stage.task-9
//
//  Created by dev on 31.07.21.
//

import UIKit

class MKDrawingView: UICollectionViewCell {
    weak var delegate: MKMainViewController?
    var currentDrawing: Int?
    var currentColor: UIColor?
    
    var shapeLayer = CAShapeLayer()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    init(frame: CGRect, currentDrawing: Int) {
        self.currentDrawing = currentDrawing
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        self.draw(drawing: self.currentDrawing!)
    }
    
    func setupForDrawing() {
        self.layer.sublayers?.first?.removeFromSuperlayer()
    }
    
    func draw(drawing: Int) {
        backgroundColor = UIColor.clear
        
        let path = self.delegate?.itemViewController?.paths?[self.currentDrawing!]
        
        self.shapeLayer.frame = self.bounds
        self.shapeLayer.path = path
        self.shapeLayer.strokeColor = self.currentColor?.cgColor
        self.shapeLayer.lineWidth = 1.0
        self.shapeLayer.fillColor = UIColor.clear.cgColor
        
        self.layer.addSublayer(self.shapeLayer)
    
        let pathAnimation = CABasicAnimation(keyPath: "strokeEnd")
        pathAnimation.duration = TimeInterval((self.delegate?.itemViewController?.currentDuration)!)
        pathAnimation.fromValue = 0.0
        pathAnimation.toValue = 1.0
        
        shapeLayer.add(pathAnimation, forKey: "strokeEnd")
    }
}
