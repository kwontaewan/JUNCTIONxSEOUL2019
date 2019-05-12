//
//  ShopListResponse.swift
//  CupcakeShopApp
//
//  Created by Gunter on 12/05/2019.
//  Copyright © 2019 Gunter. All rights reserved.
//

import Himotoki

struct ShopListResponse {
    
    let shops: [ShopModel]
    
}

extension ShopListResponse: Himotoki.Decodable {
    
    static func decode(_ e: Extractor) throws -> ShopListResponse {
        return try ShopListResponse(shops: e <| "data")
    }
    
}

struct ShopModel {
    
    let id: Int
    
    let name: String
    
    let address: String
    
    let latitude: Int
    
    let longitude: Int
    
    let createdAt: String
    
    let updatedAt: String?
    
    let deletedAt: String?
    
    let userId: Int
    
    let shopCategoryId: Int
    
}

extension ShopModel: Himotoki.Decodable {
    
    static func decode(_ e: Extractor) throws -> ShopModel {
        return try ShopModel(
            id: e <| "id",
            name: e <| "name",
            address: e <| "address",
            latitude: e <| "latitude",
            longitude: e <| "longitude",
            createdAt: e <| "createdAt",
            updatedAt: e <|? "updatedAt",
            deletedAt: e <|? "deletedAt",
            userId: e <| "userId",
            shopCategoryId: e <| "shopCategoryId"
        )
    }
    
}
