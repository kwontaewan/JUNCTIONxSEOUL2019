//
//  SignupRequest.swift
//  CupcakeShopApp
//
//  Created by Gunter on 11/05/2019.
//  Copyright © 2019 Gunter. All rights reserved.
//

import Foundation

struct SignupRequest: Codable {
    
    let email: String
    
    let password: String
    
    init(email: String, password: String, latitude: Int, longitude: Int) {
        self.email = email
        self.password = password
    }
    
}

struct ShopRegisterRequest: Codable {
    
    let name: String
    
    let latitude: Float
    
    let longitude: Float
    
    let category: Int

    init(name: String, latitude: Float, longitude: Float, category: Int) {
        self.name = name
        self.latitude = latitude
        self.longitude = longitude
        self.category = category
    }
    
}


