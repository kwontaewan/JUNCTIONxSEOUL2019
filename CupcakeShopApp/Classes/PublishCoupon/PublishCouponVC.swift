//
//  PublishCouponVC.swift
//  CupcakeShopApp
//
//  Created by Gunter on 12/05/2019.
//  Copyright © 2019 Gunter. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift
import SVProgressHUD

class PublishCouponVC: UIViewController, StoryboardInitializable {

    @IBOutlet weak var backButton: UIImageView!
    
    @IBOutlet weak var emotionLabel: UILabel!
    
    @IBOutlet weak var MenuNameLabel: UILabel!
    
    @IBOutlet weak var shopNameLabel: UILabel!
    
    @IBOutlet weak var emotionEditButton: UIButton!
    
    @IBOutlet weak var menuEditButton: UIButton!
    
    @IBOutlet weak var shopEditButton: UIButton!
    
    @IBOutlet weak var discountSlider: CustomUISlider!
    
    @IBOutlet weak var discountMin: UILabel!
    
    @IBOutlet weak var discountMax: UILabel!
    
    @IBOutlet weak var termSlider: CustomUISlider!
    
    @IBOutlet weak var termMin: UILabel!
    
    @IBOutlet weak var termMax: UILabel!
    
    @IBOutlet weak var sendButton: BorderUIButton!
    
    private var publishCouponViewModel: PublishCouponViewModeling!
    
    private let disposeBag = DisposeBag()
    
    var shopInfo: ShopInfo!
    
    var productInfo: ProductModel!
    
    var emotion: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        publishCouponViewModel = PublishCouponViewModel(publishService: PublishCouponService())
        initView()
        setupRx()
        debugPrint("shopInfo \(shopInfo) \(productInfo)")
    }
    
    private func initView() {
        
        discountSlider.setThumbImage(UIImage(named: "slide_thumup"), for: .normal)
        termSlider.setThumbImage(UIImage(named: "slide_thumup"), for: .normal)
        
        backButton.isUserInteractionEnabled = true
        backButton.addGestureRecognizer(
            UITapGestureRecognizer(
                target: self,
                action: #selector(handleDissMiss(_:)))
        )
        
        emotionLabel.text = emotion
        MenuNameLabel.text = productInfo.name
        shopNameLabel.text = shopInfo.shopTitle
        discountSlider.maximumValue = Float(productInfo.price)
        discountMax.text = "$\(String(format: "%.2f", Float(productInfo.price)))"
        
        
    }
    
    private func setupRx() {
        
        publishCouponViewModel.progressBinding
            .bind(to: SVProgressHUD.rx.isAnimating)
            .disposed(by: disposeBag)
        
        publishCouponViewModel.publishCouponResponse
            .subscribe(onNext: { [unowned self] (response) in
                switch response {
                case .Success(_):
                    self.showAlert()
                case .Error(let error):
                    debugPrint("error \(error)")
                }
            }).disposed(by: disposeBag)
        
        let discountSliderEvent = discountSlider.rx.value.share(replay: 1)
        
        let termSliderEvent = termSlider.rx.value.share(replay: 1)
        
        publishCouponViewModel.name.onNext(productInfo.name)
        
        discountSliderEvent
            .bind(to: publishCouponViewModel.price)
            .disposed(by: disposeBag)
        
        publishCouponViewModel.emotion.onNext(EmotionValue.getIdx(value: emotion))
        
        publishCouponViewModel.shopId.onNext(shopInfo.idx)
        
        termSliderEvent
            .bind(to: publishCouponViewModel.expire)
            .disposed(by: disposeBag)
        
        sendButton.rx.tap
            .bind(to: publishCouponViewModel.sendButton)
            .disposed(by: disposeBag)
        
        discountSliderEvent
            .subscribe(onNext: { [unowned self] (value) in
                self.discountMin.text = "$\(String(format: "%.2f", value))"
                debugPrint(" \(value)")
            }).disposed(by: disposeBag)
        
        termSliderEvent
            .subscribe(onNext: { [unowned self] (value) in
                debugPrint("\(value)")
                if value <= 1 {
                    self.termMin.text = "To day"
                } else {
                    self.termMin.text = "\(Int(value)) day"
                }
            }).disposed(by: disposeBag)
        
    }
    
    @objc func handleDissMiss(_ sender: UITapGestureRecognizer) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    func showAlert() {
        let alertController = UIAlertController(title: "Coupon issue",
                                                message: "Coupon transfer was successful",
                                                preferredStyle: UIAlertController.Style.alert)
        
        alertController.addAction(
            UIAlertAction(
                title: "YES",
                style: UIAlertAction.Style.default,
                handler: { action in
                    self.navigationController?.popToRootViewController(animated: false)
            })
        )
        
        self.present(alertController, animated: true, completion: nil)
    }
    

}



