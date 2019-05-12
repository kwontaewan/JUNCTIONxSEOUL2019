//
//  ProductListResponse.swift
//  CupcakeShopApp
//
//  Created by Gunter on 12/05/2019.
//  Copyright © 2019 Gunter. All rights reserved.
//

import Himotoki

struct ProductListResponse {
    
    let products: [ProductModel]
    
}

extension ProductListResponse: Himotoki.Decodable {
    
    static func decode(_ e: Extractor) throws -> ProductListResponse {
        return try ProductListResponse(products: e <| "data")
    }
    
}

struct ProductModel {
    
    let id: Int
    
    let name: String
    
    let price: Int
    
    let order: Int
    
    let createdAt: String
    
    let updatedAt: String?
    
    let deletedAt: String?
    
    let shopId: Int
    
}

extension ProductModel: Himotoki.Decodable {
    
    static func decode(_ e: Extractor) throws -> ProductModel {
        return try ProductModel(
            id: e <| "id",
            name: e <| "name",
            price: e <| "price",
            order: e <| "order",
            createdAt: e <| "createdAt",
            updatedAt: e <|? "updatedAt",
            deletedAt: e <|? "deletedAt",
            shopId: e <| "shopId"
        )
    }
    
}
