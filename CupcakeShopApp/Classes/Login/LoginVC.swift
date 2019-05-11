//
//  LoginVC.swift
//  CupcakeShopApp
//
//  Created by Gunter on 11/05/2019.
//  Copyright © 2019 Gunter. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift
import SVProgressHUD

class LoginVC: UIViewController {

    @IBOutlet weak var backButton: UIImageView!
    
    @IBOutlet weak var emailTextField: UnderLineTextField!
    
    @IBOutlet weak var passwordTextField: UnderLineTextField!
    
    @IBOutlet weak var LoginButton: BorderUIButton!
    
    @IBOutlet weak var forgotPwButton: UIButton!
    
    private var loginViewModel: LoginViewModeling!
    
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loginViewModel = LoginViewModel(
            loginService: LoginService()
        )
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
        
        loginViewModel.progreeBinding
            .bind(to: SVProgressHUD.rx.isAnimating)
            .disposed(by: disposeBag)
        
        let email = emailTextField.rx
            .text
            .orEmpty
            .share(replay: 1)
        
        let password = passwordTextField.rx
            .text
            .orEmpty
            .share(replay: 1)
        
        let emailValidator = TextValidator(input: email)
        
        let passwordValidator = TextValidator(input: password)
        
        let formValidate = Observable.combineLatest(
            emailValidator.validate(),
            emailValidator.isEamilvalidate(),
            passwordValidator.validate()
        )
        
        formValidate.subscribe(onNext: { [unowned self] (mEmail, mEmailFormat, mPassword) in
            //debugPrint("formValidate \(mEmail) \(mEmailFormat) \(mPassword)")
            if mEmail && mEmailFormat && mPassword {
                self.LoginButton.isEnabled = true
                self.LoginButton.backgroundColor = UIColor.mainColor
            } else {
                self.LoginButton.isEnabled = false
                self.LoginButton.backgroundColor = UIColor.disableButtonColor
            }
            
        }).disposed(by: disposeBag)
        
        email.bind(to: loginViewModel.email)
            .disposed(by: disposeBag)
        
        password.bind(to: loginViewModel.password)
            .disposed(by: disposeBag)
        
        LoginButton.rx.tap
            .bind(to: loginViewModel.tapLoginButton)
            .disposed(by: disposeBag)
        
        loginViewModel.loginResponse
            .subscribe(onNext: { (response) in
                switch response {
                case .Success(let authToken):
                    debugPrint("auth \(authToken)")
                    AppSessionManager.setAuthToken(authToken: authToken.refresh)
                case .Error(let error):
                    debugPrint("error \(error)")
                }
            }).disposed(by: disposeBag)
        
    }
    
    @objc func handleDissMiss(_ sender: UITapGestureRecognizer) {
        self.navigationController?.popViewController(animated: true)
    }
    
}
