//
//  MainService.swift
//  CupcakeShopApp
//
//  Created by Gunter on 12/05/2019.
//  Copyright © 2019 Gunter. All rights reserved.
//

import RxSwift

enum Main {
    
    case shopList
    
    var url: String {
        switch self {
        case .shopList:
            return "/shops"
        }
    }
    
}

protocol MainServicing {
    
    func shopList() -> Observable<[ShopModel]>
    
}

class MainService: MainServicing {
    
    func shopList() -> Observable<[ShopModel]> {
        let url = Main.shopList.url
        return Network.shared.request2(method: .get, url: url, parameters: nil, type: ShopListResponse.self).map { $0.shops }
    }
    
}
