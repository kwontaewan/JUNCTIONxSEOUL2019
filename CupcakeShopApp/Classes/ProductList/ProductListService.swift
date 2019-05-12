//
//  ProductListService.swift
//  CupcakeShopApp
//
//  Created by Gunter on 12/05/2019.
//  Copyright © 2019 Gunter. All rights reserved.
//

import RxSwift

enum ProductList {
    
    case products(shopId: Int)
    
    var url: String {
        switch self {
        case .products(let shopId):
            return "/products?shop=\(shopId)"
        }
    }
    
}

protocol ProductListServicing {
    
    func products(shopIdx: Int) -> Observable<[ProductModel]>
    
}

class ProductListSerivce: ProductListServicing {
    
    func products(shopIdx: Int) -> Observable<[ProductModel]> {
        let url  = ProductList.products(shopId: shopIdx).url
        return Network.shared.request2(method: .get, url: url, parameters: nil, type: ProductListResponse.self).map { $0.products }
    }
    
}
