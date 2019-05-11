//
//  LoginRequest.swift
//  CupcakeShopApp
//
//  Created by Gunter on 11/05/2019.
//  Copyright © 2019 Gunter. All rights reserved.
//

import Foundation

struct LoginRequest: Codable {
    
    let email: String
    
    let password: String
    
    init(email: String, password: String) {
        self.email = email
        self.password = password
    }
    
}
