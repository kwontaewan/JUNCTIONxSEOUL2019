//
//  PublishCouponService.swift
//  CupcakeShopApp
//
//  Created by Gunter on 12/05/2019.
//  Copyright © 2019 Gunter. All rights reserved.
//

import RxSwift

enum PublishCoupon {
    
    case coupon
    
    var url: String {
        switch self {
        case .coupon:
            return "/coupons"
        }
    }
    
}

protocol PublishCouponServicing {
    
    func pulishCoupon(param: [String: Any]?) -> Observable<APIResult<Any>>
    
}

class PublishCouponService: PublishCouponServicing {
    
    func pulishCoupon(param: [String : Any]?) -> Observable<APIResult<Any>> {
        let url = PublishCoupon.coupon.url
        return Network.shared.requestNoResponse(method: .post, url: url, parameters: param)
    }
    
}
