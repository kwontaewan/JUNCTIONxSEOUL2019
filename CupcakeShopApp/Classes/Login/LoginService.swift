//
//  LoginService.swift
//  CupcakeShopApp
//
//  Created by Gunter on 11/05/2019.
//  Copyright © 2019 Gunter. All rights reserved.
//

import RxSwift

enum Login {
    
    case login
    
    var url: String {
        switch self {
        case .login:
            return "/auth"
        }
    }
    
}

protocol LoginServicing {
    
    func login(param: [String: Any]?) -> Observable<APIResult<TokenResponse>>
    
}

class LoginService: LoginServicing {
    
    func login(param: [String : Any]?) -> Observable<APIResult<TokenResponse>> {
        let url = Login.login.url
        return Network.shared.request(method: .post, url: url, parameters: param, type: TokenResponse.self)
    }
    
}
