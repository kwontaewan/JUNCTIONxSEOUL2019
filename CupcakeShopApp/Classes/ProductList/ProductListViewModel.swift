//
//  ProductListViewModel.swift
//  CupcakeShopApp
//
//  Created by Gunter on 12/05/2019.
//  Copyright © 2019 Gunter. All rights reserved.
//

import RxSwift

protocol ProductListViewModeling {
    
    // MARK: - Input
    var progressBinding: Observable<Bool> { get }
    
    var viewDidAppear: PublishSubject<Void> { get }
    
    // MARK: - Output
    var productList: Observable<[ProductModel]>! { get }
}

class ProductListViewModel: ProductListViewModeling {
    
    // MARK: - Input
    let progressView = ActivityIndicator()
    
    var progressBinding: Observable<Bool> {
        return progressView.asObservable()
    }
    var viewDidAppear: PublishSubject<Void> = PublishSubject<Void>()
    
    
    // MARK: - Output
    var productList: Observable<[ProductModel]>!
    
    init(productService: ProductListServicing, shopId: Int) {
        
        productList = viewDidAppear.flatMapLatest({ _ -> Observable<[ProductModel]> in
            return productService.products(shopIdx: shopId)
                .catchErrorJustReturn([])
                .observeOn(MainScheduler.instance)
        })
        
    }
    
}
