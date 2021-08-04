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
    
    var paths: [CGPath]?
    var duration: Int?
    
    var shapeLayer = CAShapeLayer()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        
        self.draw(drawing: self.currentDrawing!)
    }
    
    func setupForDrawing() {
        self.layer.sublayers?.first?.removeFromSuperlayer()
    }
    
    func draw(drawing: Int) {
        let layer = CAShapeLayer(layer: layer)
        layer.lineCap = CAShapeLayerLineCap.round
        layer.lineJoin = .bevel
        layer.fillColor = UIColor.clear.cgColor
        layer.lineWidth = 1.0
        layer.strokeEnd = 0.0
        
        layer.path = self.paths?[self.currentDrawing!]
        layer.strokeColor = self.currentColor?.cgColor
        self.layer.addSublayer(layer)
        
        let pathAnimation = CABasicAnimation(keyPath: "strokeEnd")
        pathAnimation.duration = CFTimeInterval((self.duration)!)
        pathAnimation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.linear)
        pathAnimation.fromValue = 0.0
        pathAnimation.toValue = 1.0
        pathAnimation.autoreverses = false;
        
        layer.add(pathAnimation, forKey: "strokeEndAnimation")
        layer.strokeEnd = 1.0
    }
}
