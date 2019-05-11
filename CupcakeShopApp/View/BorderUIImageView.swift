//
//  BorderUIImageView.swift
//  CupcakeShopApp
//
//  Created by Gunter on 12/05/2019.
//  Copyright © 2019 Gunter. All rights reserved.
//

import UIKit


@IBDesignable
class BorderUIImageView: UIImageView {
    
    @IBInspectable var cornerRadius: CGFloat = 0 {
        didSet {
            layer.cornerRadius = cornerRadius
            layer.masksToBounds = cornerRadius > 0
        }
    }
    
    @IBInspectable var borderWidth: CGFloat = 0 {
        didSet {
            layer.borderWidth = borderWidth
        }
    }
    
    @IBInspectable var borderColor: UIColor? {
        didSet {
            layer.borderColor = borderColor?.cgColor
        }
    }
    
    @IBInspectable open var roundedView: Bool {
        
        get {
            return true
        }
        
        set {
            if newValue {
                self.layer.cornerRadius = self.frame.size.width / 2
                self.clipsToBounds = true
            }
        }
        
    }
    
}
