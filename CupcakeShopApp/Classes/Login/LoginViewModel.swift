//
//  LoginViewModel.swift
//  CupcakeShopApp
//
//  Created by Gunter on 11/05/2019.
//  Copyright © 2019 Gunter. All rights reserved.
//

import RxSwift

protocol LoginViewModeling {
    // MARK: - Input
    var progreeBinding: Observable<Bool> { get }
    
    var email: PublishSubject<String> { get }
    
    var password: PublishSubject<String> { get }
    
    var tapLoginButton: PublishSubject<Void> { get }
    
    // MARK: - Output
    var loginResponse: Observable<APIResult<TokenResponse>>! { get }
    
}

class LoginViewModel: LoginViewModeling {
    
    // MARK: - Input
    let progreeview = ActivityIndicator()
    
    var progreeBinding: Observable<Bool> {
        return progreeview.asObservable()
    }
    
    var email: PublishSubject<String> = PublishSubject<String>()
    
    var password: PublishSubject<String> = PublishSubject<String>()
    
    var tapLoginButton: PublishSubject<Void> = PublishSubject<Void>()
    
    // MARK: - Output
    var loginResponse: Observable<APIResult<TokenResponse>>!
    
    init(loginService: LoginServicing) {
        
        let requestParam = Observable.combineLatest(email, password)
        
        loginResponse = tapLoginButton.withLatestFrom(requestParam)
            .flatMapLatest({ [unowned self] (email, password) -> Observable<APIResult<TokenResponse>> in
                let loginRequest = LoginRequest(
                    email: email,
                    password: password
                )
                
                let param = loginRequest.dictionary
                
                return loginService.login(param: param)
                    .catchError({ (error) -> Observable<APIResult<TokenResponse>> in
                        Observable.just(APIResult.Error(error))
                    }).trackActivity(self.progreeview)
                    .observeOn(MainScheduler.instance)
            
            })
        
    }
    
}
