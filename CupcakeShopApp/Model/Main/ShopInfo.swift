//
//  ShopInfo.swift
//  CupcakeShopApp
//
//  Created by Gunter on 12/05/2019.
//  Copyright © 2019 Gunter. All rights reserved.
//

import Foundation
import UIKit

struct ShopInfo {
    
    let shopImage: UIImage
    
    let shopTitle: String
    
    let shopAddress: String
    
    init(shopImage: UIImage, shopTitle: String, shopAddress: String) {
        self.shopImage = shopImage
        self.shopTitle = shopTitle
        self.shopAddress = shopAddress
    }
    
}
