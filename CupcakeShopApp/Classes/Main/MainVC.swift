//
//  MainVC.swift
//  CupcakeShopApp
//
//  Created by Gunter on 11/05/2019.
//  Copyright © 2019 Gunter. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

class MainVC: UIViewController {

    @IBOutlet weak var alramButton: UIButton!
    
    @IBOutlet weak var menuButton: UIButton!
    
    @IBOutlet weak var registerButton: UIButton!
    
    @IBOutlet weak var shopCollectionView: UICollectionView!
    
    @IBOutlet weak var happinessView: BorderUIView!
    
    @IBOutlet weak var surpriseView: BorderUIView!
    
    @IBOutlet weak var fearView: BorderUIView!
    
    @IBOutlet weak var sadnessView: BorderUIView!
    
    @IBOutlet weak var angerView: BorderUIView!
    
    @IBOutlet weak var disgustView: BorderUIView!
    
    @IBOutlet weak var notRegisterView: UIView!
    
    @IBOutlet weak var shopRegisterView: UIView!
    
    @IBOutlet weak var shopRegisterViewHeightConstraint: NSLayoutConstraint!
    
    private let disposeBag = DisposeBag()
    
    private var shopList: [ShopInfo]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initView()
        setupRx()
        // Do any additional setup after loading the view.
    }
    
    private func initView() {
        
        shopList = [
            ShopInfo(shopImage: UIImage(named: "card1")!, shopTitle: "Butterfinger\nPancakes Branch", shopAddress: "11, Seolleung-ro 152-gil, Gangnam-gu,\nSeoul, Republic of Korea"),
            ShopInfo(shopImage: UIImage(named: "card2")!, shopTitle: "Gunter Shop", shopAddress: "19, Seolleung-ro 153-gil, Gangnam-gu,\nSeoul, Republic of Korea")
        ]
        
        self.shopCollectionView.isPagingEnabled = true

    }
    
    private func setupRx() {
        
        Observable.just(shopList)
            .asDriver(onErrorJustReturn: [])
            .drive(shopCollectionView.rx.items(cellIdentifier: "ShopInfoCell", cellType: ShopInfoCell.self)) { row, model, cell in
                
                return cell
            }.disposed(by: disposeBag)
        
    }


}
