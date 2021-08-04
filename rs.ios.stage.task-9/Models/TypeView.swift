//
//  TypeView.swift
//  rs.ios.stage.task-9
//
//  Created by dev on 4.08.21.
//

import UIKit

class TypeView: UILabel {
    
    var topInset: CGFloat = 8.0
    var bottomInset: CGFloat = 3.0
    var leftInset: CGFloat = 30.0
    var rightInset: CGFloat = 30.0
    
    override func drawText(in rect: CGRect) {
        let insets = UIEdgeInsets.init(top: topInset, left: leftInset, bottom: bottomInset, right: rightInset)
        super.drawText(in: rect.inset(by: insets))
    }
    
    override var intrinsicContentSize: CGSize {
        let size = super.intrinsicContentSize
        return CGSize(width: size.width + leftInset + rightInset,
                      height: size.height + topInset + bottomInset)
    }
}
