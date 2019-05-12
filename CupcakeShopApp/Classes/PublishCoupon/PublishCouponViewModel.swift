//
//  PublishCouponViewModel.swift
//  CupcakeShopApp
//
//  Created by Gunter on 12/05/2019.
//  Copyright © 2019 Gunter. All rights reserved.
//

import RxSwift

protocol PublishCouponViewModeling {
    
    // MARK: - Input
    var progressBinding: Observable<Bool> { get }
    
    var name: PublishSubject<String> { get }
    
    var price: BehaviorSubject<Float> { get }
    
    var emotion: PublishSubject<Int> { get }
    
    var shopId: PublishSubject<Int> { get }
    
    var expire: BehaviorSubject<Float> { get }
    
    var sendButton: PublishSubject<Void> { get }
    
    // MARK: - Output
    var publishCouponResponse: Observable<APIResult<Any>>! { get }
    
}

class PublishCouponViewModel: PublishCouponViewModeling {
    
    // MARK: - Input
    let progressView = ActivityIndicator()
    
    var progressBinding: Observable<Bool> {
        return progressView.asObservable()
    }
    
    var name: PublishSubject<String> = PublishSubject<String>()
    
    var price: BehaviorSubject<Float> = BehaviorSubject<Float>(value: 0.0)
    
    var emotion: PublishSubject<Int> = PublishSubject<Int>()
    
    var shopId: PublishSubject<Int> = PublishSubject<Int>()
    
    var expire: BehaviorSubject<Float> = BehaviorSubject<Float>(value: 0.0)
    
    var sendButton: PublishSubject<Void> = PublishSubject<Void>()
    
    // MARK: - Output
    var publishCouponResponse: Observable<APIResult<Any>>!
    
    init(publishService: PublishCouponServicing) {
        
        let requestParma = Observable.combineLatest(name, price, emotion, shopId, expire)
        
        publishCouponResponse = sendButton.withLatestFrom(requestParma)
            .flatMapLatest({ (mName, mPrice, mEmotion, mShopId, mExpire) -> Observable<APIResult<Any>> in
                
                let now = Date()
                let expireDate = Calendar.current.date(byAdding: .day, value: Int(mExpire), to: now)
                let date = DateFormatter()
                date.locale = Locale(identifier: "ko_kr")
                date.timeZone = TimeZone(abbreviation: "KST") // "2018-03-21 18:07:27"
                //date.timeZone = TimeZone(abbreviation: "NZST") // "2018-03-21 22:06:39"
                date.dateFormat = "yyyy-MM-dd HH:mm:ss"
                let kr = date.string(from: expireDate ?? Date())
                
                let reqestData = PublishCouponRequest(
                    name: mName,
                    price: mPrice,
                    emotion: mEmotion,
                    shop: mShopId,
                    count: 1,
                    expire: kr
                )
                
                let param = reqestData.dictionary
                
                debugPrint("param \(param)")
                
                return publishService.pulishCoupon(param: param)
                    .catchError({ (error) -> Observable<APIResult<Any>> in
                        return Observable.just(APIResult.Error(error))
                    }).trackActivity(self.progressView)
                    .observeOn(MainScheduler.instance)
                
            })
        
    }
    
    
}

