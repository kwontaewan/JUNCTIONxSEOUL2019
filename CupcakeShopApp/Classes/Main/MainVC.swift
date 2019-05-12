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
    
    private var mainViewModel: MainViewModeling!
    
    private let disposeBag = DisposeBag()
    
    private var shopIds: [ShopInfo]!
    
    private var currentPage = 0
    
    private weak var shadowView: UIView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mainViewModel = MainViewModel(mainService: MainService())
        initView()
        setupRx()
        // Do any additional setup after loading the view.
    }
    
    private func initView() {
        
        happinessView.isUserInteractionEnabled = true
        happinessView.addGestureRecognizer(
            UITapGestureRecognizer(
                target: self,
                action: #selector(handleHappiness(_:)))
        )
        
        surpriseView.isUserInteractionEnabled = true
        surpriseView.addGestureRecognizer(
            UITapGestureRecognizer(
                target: self,
                action: #selector(handleSurpriseView(_:)))
        )
        
        fearView.isUserInteractionEnabled = true
        fearView.addGestureRecognizer(
            UITapGestureRecognizer(
                target: self,
                action: #selector(handleFearView(_:)))
        )
        
        sadnessView.isUserInteractionEnabled = true
        sadnessView.addGestureRecognizer(
            UITapGestureRecognizer(
                target: self,
                action: #selector(handleSadnessView(_:)))
        )
        
        angerView.isUserInteractionEnabled = true
        angerView.addGestureRecognizer(
            UITapGestureRecognizer(
                target: self,
                action: #selector(handleAngerView(_:)))
        )
        
        disgustView.isUserInteractionEnabled = true
        disgustView.addGestureRecognizer(
            UITapGestureRecognizer(
                target: self,
                action: #selector(handleDisgust(_:)))
        )
        
        self.shopCollectionView.isPagingEnabled = true

    }
    
    private func setupRx() {
        
        
        mainViewModel.shopList
            .asDriver(onErrorJustReturn: [])
            .drive(shopCollectionView.rx.items(cellIdentifier: "ShopInfoCell", cellType: ShopInfoCell.self)) { row, model, cell in
                
                cell.shopNameLabel.text = model.name
                cell.shopAddressLabel.text = model.address
                
            }.disposed(by: disposeBag)
        
        mainViewModel.shopIds
            .subscribe(onNext: { [unowned self] (shopIds) in
                self.shopIds = shopIds
                debugPrint("ids \(shopIds)")
            }).disposed(by: disposeBag)
        
        rx.viewDidAppear
            .bind(to: mainViewModel.viewDidAppear)
            .disposed(by: disposeBag)
        
        shopCollectionView.rx.didScroll
            .subscribe(onNext: { [unowned self] _ in
                var visibleRect = CGRect()
                
                visibleRect.origin = self.shopCollectionView.contentOffset
                visibleRect.size = self.shopCollectionView.bounds.size
                
                let visiblePoint = CGPoint(x: visibleRect.midX, y: visibleRect.midY)
                
                guard let indexPath = self.shopCollectionView.indexPathForItem(at: visiblePoint) else { return }
                self.currentPage = indexPath.row
                debugPrint(self.currentPage)
                
            }).disposed(by: disposeBag)
        
    }
    
    @objc func handleHappiness(_ sender: UITapGestureRecognizer) {
        debugPrint("Happiness")
        showAlert(emotion: "hapiness")
    }
    
    @objc func handleSurpriseView(_ sender: UITapGestureRecognizer) {
        debugPrint("handleSurpriseView")
        showAlert(emotion: "surprise")
    }
    
    @objc func handleFearView(_ sender: UITapGestureRecognizer) {
        debugPrint("handleFearView")
        showAlert(emotion: "fear")
    }
    
    @objc func handleSadnessView(_ sender: UITapGestureRecognizer) {
        debugPrint("handleSadnessView")
        showAlert(emotion: "sadness")
    }
    
    @objc func handleAngerView(_ sender: UITapGestureRecognizer) {
        debugPrint("handleAngerView")
        showAlert(emotion: "anger")
    }
    
    @objc func handleDisgust(_ sender: UITapGestureRecognizer) {
        debugPrint("handleDisgust")
        showAlert(emotion: "disgust")
    }
    
    func showAlert(emotion: String) {
        let alertController = UIAlertController(title: "Coupon issue",
                                                message: "A message should be a short, complete sentence.",
                                                preferredStyle: UIAlertController.Style.alert)
        
        alertController.addAction(
            UIAlertAction(
                title: "NO",
                style: UIAlertAction.Style.default,
                handler: { [unowned self] action in
                    
            })
        )
        
        alertController.addAction(
            UIAlertAction(
                title: "YES",
                style: UIAlertAction.Style.default,
                handler: { action in
                    self.showProductView(emotion: emotion)
            })
        )

        self.present(alertController, animated: true, completion: nil)
    }
    
    private func showProductView(emotion: String) {
        let vc = ProductListVC.initFromStoryboard(name: "Main")
        vc.shopInfo = shopIds[currentPage]
        vc.emotion = emotion
        self.navigationController?.show(vc, sender: nil)
    }

}
