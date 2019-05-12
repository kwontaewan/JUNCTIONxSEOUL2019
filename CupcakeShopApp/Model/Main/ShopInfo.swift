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
    
    let shopTitle: String
    
    let shopAddress: String
    
    let idx: Int
    
    init(shopTitle: String, shopAddress: String, idx: Int) {
        self.shopTitle = shopTitle
        self.shopAddress = shopAddress
        self.idx = idx
    }
    
}
