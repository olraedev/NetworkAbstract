//
//  LoginViewController.swift
//  NetworkAbstract
//
//  Created by SangRae Kim on 4/11/24.
//

import UIKit
import RxSwift
import RxCocoa

class LoginViewController: UIViewController {
    
    let emailTextField = {
        let view = UITextField()
        view.placeholder = "이메일"
        view.borderStyle = .roundedRect
        view.autocapitalizationType = .none
        return view
    }()
    
    let passwordTextField = {
        let view = UITextField()
        view.placeholder = "비밀번호"
        view.borderStyle = .roundedRect
        view.autocapitalizationType = .none
        return view
    }()
    
    let loginButton = {
        let view = UIButton()
        view.setTitle("로그인", for: .normal)
        view.backgroundColor = .black
        view.setTitleColor(.white, for: .normal)
        return view
    }()
    
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureView()
        bind()
    }
    
    func bind() {
        let a = Observable.combineLatest(emailTextField.rx.text.orEmpty, passwordTextField.rx.text.orEmpty)
            .map { email, password in
                return LoginQuery(email: email, password: password)
            }
        
        loginButton.rx.tap
            .withLatestFrom(a)
            .flatMap { query in
                NetworkManager.login(query: query)
            }
            .subscribe(with: self) { owner, model in
                UserDefaults.standard.setValue(model.accessToken, forKey: "accessToken")
                UserDefaults.standard.setValue(model.refreshToken, forKey: "refreshTokenr")
            }
            .disposed(by: disposeBag)
    }
    
    func configureView() {
        view.backgroundColor = .white
        
        view.addSubview(emailTextField)
        emailTextField.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(40)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(40)
        }
        
        view.addSubview(passwordTextField)
        passwordTextField.snp.makeConstraints { make in
            make.top.equalTo(emailTextField.snp.bottom).offset(16)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(40)
        }
        
        view.addSubview(loginButton)
        loginButton.snp.makeConstraints { make in
            make.top.equalTo(passwordTextField.snp.bottom).offset(32)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(40)
        }
    }
}
