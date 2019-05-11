//
//  CustomUISlider.swift
//  CupcakeShopApp
//
//  Created by Gunter on 12/05/2019.
//  Copyright © 2019 Gunter. All rights reserved.
//

import UIKit

@IBDesignable
class CustomUISlider : UISlider {
    
    override func trackRect(forBounds bounds: CGRect) -> CGRect {
        
        //keeps original origin and width, changes height, you get the idea
        let customBounds = CGRect(origin: bounds.origin, size: CGSize(width: bounds.size.width, height: 6.0))
        super.trackRect(forBounds: customBounds)
        return customBounds
    }
    
    //while we are here, why not change the image here as well? (bonus material)
    override func awakeFromNib() {
        self.setThumbImage(UIImage(named: "customThumb"), for: .normal)
        super.awakeFromNib()
    }
}
