//
//  JoinViewController.swift
//  NetworkAbstract
//
//  Created by SangRae Kim on 4/11/24.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

class JoinViewController: UIViewController {
    
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
    
    let nickTextField = {
        let view = UITextField()
        view.placeholder = "닉네임"
        view.borderStyle = .roundedRect
        view.autocapitalizationType = .none
        return view
    }()
    
    let joinButton = {
        let view = UIButton()
        view.setTitle("가입하기", for: .normal)
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
        let a = Observable.combineLatest(emailTextField.rx.text.orEmpty, passwordTextField.rx.text.orEmpty, nickTextField.rx.text.orEmpty)
            .map { email, password, nick in
                return JoinQuery(email: email, password: password, nick: nick, phoneNum: nil, birthDay: nil)
            }
        
        joinButton.rx.tap
            .withLatestFrom(a)
            .flatMap { query in
                NetworkManager.join(query: query)
            }
            .subscribe(with: self) { owner, model in
                print(model)
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
        
        view.addSubview(nickTextField)
        nickTextField.snp.makeConstraints { make in
            make.top.equalTo(passwordTextField.snp.bottom).offset(16)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(40)
        }
        
        view.addSubview(joinButton)
        joinButton.snp.makeConstraints { make in
            make.top.equalTo(nickTextField.snp.bottom).offset(32)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(40)
        }
    }
}
