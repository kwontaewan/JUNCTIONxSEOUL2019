//
//  SplashAnimationView.swift
//  CupcakeShopApp
//
//  Created by Gunter on 11/05/2019.
//  Copyright © 2019 Gunter. All rights reserved.
//

import UIKit

class SplashAnimationView: UIView {
    
    let logo = UIImage(named: "ic_logo")

    override init(frame: CGRect) {
        super.init(frame: frame)
        splashInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        splashInit()
    }
    
    private func splashInit() {
        
        let image = UIImageView()
        image.image = logo
        backgroundColor = UIColor.mainColor
        image.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        image.contentMode = .scaleAspectFill
        // Add the Animation
        addSubview(image)
        image.translatesAutoresizingMaskIntoConstraints = false
        image.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        image.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        
    }
    
}
