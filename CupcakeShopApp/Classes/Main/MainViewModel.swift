//
//  MainViewModel.swift
//  CupcakeShopApp
//
//  Created by Gunter on 12/05/2019.
//  Copyright © 2019 Gunter. All rights reserved.
//

import RxSwift

protocol MainViewModeling {
    
    // MARK: - Input
    var progressBinding: Observable<Bool> { get }
    
    var viewDidAppear: PublishSubject<Void> { get }
    
    // MARK: - Output
    var shopList: Observable<[ShopModel]>! { get }
    
    var shopIds: Observable<[ShopInfo]>! { get }
}

class MainViewModel: MainViewModeling {
    
    // MARK: - Input
    let progressView = ActivityIndicator()
    
    var progressBinding: Observable<Bool> {
        return progressView.asObservable()
    }
    var viewDidAppear: PublishSubject<Void> = PublishSubject<Void>()
    
    // MARK: - Output
    var shopList: Observable<[ShopModel]>!
    
    var shopIds: Observable<[ShopInfo]>!
    
    init(mainService: MainServicing) {
        
        shopList = viewDidAppear.flatMapLatest({ [unowned self] _ -> Observable<[ShopModel]> in
            return mainService.shopList()
                .catchErrorJustReturn([])
                .trackActivity(self.progressView)
                .observeOn(MainScheduler.instance)
        }).share(replay: 1)
        
        shopIds = shopList.flatMapLatest({ (shopList) -> Observable<[ShopInfo]> in
            return Observable.just(
                shopList.map { ShopInfo(
                    shopTitle: $0.name,
                    shopAddress: $0.address,
                    idx: $0.id)
                }
            )
        })
        
    }
    
}
