//
//  ProductListVC.swift
//  CupcakeShopApp
//
//  Created by Gunter on 12/05/2019.
//  Copyright © 2019 Gunter. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class ProductListVC: UIViewController, StoryboardInitializable {
    
    @IBOutlet weak var backButton: UIImageView!
    
    @IBOutlet weak var productCollectionView: UICollectionView!
    
    private var productViewModel: ProductListViewModeling!
    
    private let disposeBag = DisposeBag()
    
    var shopInfo: ShopInfo!
    
    var emotion: String!
    
    var emotionId: Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        debugPrint("shopIdx \(shopInfo)")
        productViewModel = ProductListViewModel(productService: ProductListSerivce(), shopId: shopInfo.idx)
        initView()
        setupRx()
    }
    
    private func initView() {
        backButton.isUserInteractionEnabled = true
        backButton.addGestureRecognizer(
            UITapGestureRecognizer(
                target: self,
                action: #selector(handleDissMiss(_:)))
        )
    }
    
    private func setupRx() {
        
        rx.viewDidAppear
            .bind(to: productViewModel.viewDidAppear)
            .disposed(by: disposeBag)
        
        productViewModel.productList
            .asDriver(onErrorJustReturn: [])
            .drive(productCollectionView.rx.items(cellIdentifier: "ProductCell", cellType: ProductCell.self)) { row, model, cell in
                cell.productNameLabel.text = model.name
                cell.priceLabel.text = "$\(model.price)"
            }.disposed(by: disposeBag)
        
        Observable.zip(
            productCollectionView.rx.itemSelected,
            productCollectionView.rx.modelSelected(ProductModel.self)
            )
            .bind{ [unowned self] indexPath, model in
                debugPrint("did selected \(model)")
                let vc = PublishCouponVC.initFromStoryboard(name: "Main")
                vc.productInfo = model
                vc.emotion = self.emotion
                vc.shopInfo = self.shopInfo
                self.navigationController?.show(vc, sender: nil)
            }
            .disposed(by: disposeBag)
        
    }
    
    @objc func handleDissMiss(_ sender: UITapGestureRecognizer) {
        self.navigationController?.popViewController(animated: true)
    }
    
}
