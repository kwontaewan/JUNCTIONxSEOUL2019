//
//  PublishCouponRequest.swift
//  CupcakeShopApp
//
//  Created by Gunter on 12/05/2019.
//  Copyright © 2019 Gunter. All rights reserved.
//

import Foundation

struct PublishCouponRequest: Codable {
    
    let name: String
    
    let price: Float
    
    let emotion: Int
    
    let shop: Int
    
    let count: Int
    
    let expire: String
    
    init(name: String, price: Float, emotion: Int, shop: Int, count: Int, expire: String) {
        self.name = name
        self.price = price
        self.emotion = emotion
        self.shop = shop
        self.count = count
        self.expire = expire
    }
    
}

