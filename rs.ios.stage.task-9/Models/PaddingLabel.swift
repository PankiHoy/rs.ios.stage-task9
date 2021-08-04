//
//  PaddingLabel.swift
//  rs.ios.stage.task-9
//
//  Created by dev on 4.08.21.
//

import UIKit

class PaddingLabel: UILabel {
    
    override func drawText(in rect: CGRect) {
        let insets = UIEdgeInsets(top: 30, left: 30, bottom: 30, right: 40)
        super.drawText(in: rect.inset(by: insets))
    }
    
    override var intrinsicContentSize: CGSize {
        let size = super.intrinsicContentSize
        return CGSize(width: size.width + 60, height: size.height + 60)
    }
    
}
