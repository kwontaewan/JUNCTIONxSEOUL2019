//
//  LoginResponse.swift
//  CupcakeShopApp
//
//  Created by Gunter on 11/05/2019.
//  Copyright © 2019 Gunter. All rights reserved.
//

import Himotoki

struct TokenResponse {
    
    let access: String
    
    let refresh: String
    
}

extension TokenResponse: Himotoki.Decodable {
    
    static func decode(_ e: Extractor) throws -> TokenResponse {
        return try TokenResponse(
            access: e <| "access",
            refresh: e <| "refresh"
        )
    }
    
}
