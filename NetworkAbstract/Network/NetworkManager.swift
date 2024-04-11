//
//  NetworkManager.swift
//  NetworkAbstract
//
//  Created by SangRae Kim on 4/11/24.
//

import Foundation
import Alamofire
import RxSwift

class NetworkManager {
    static func join(query: JoinQuery) -> Single<JoinModel> {
        return Single<JoinModel>.create { single in
            do {
                let urlRequest = try Router.join(query: query).asURLRequest()
                
                AF.request(urlRequest)
                    .validate(statusCode: 200..<300)
                    .responseDecodable(of: JoinModel.self) { response in
                        switch response.result {
                        case .success(let model):
                            single(.success(model))
                        case .failure(let fail):
                            single(.failure(fail))
                        }
                    }
            } catch {
                
            }
            
            return Disposables.create()
        }
    }
    
    static func login(query: LoginQuery) -> Single<LoginModel> {
        return Single<LoginModel>.create { single in
            do {
                let urlRequest = try Router.login(query: query).asURLRequest()
                
                AF.request(urlRequest)
                    .validate(statusCode: 200..<300)
                    .responseDecodable(of: LoginModel.self) { response in
                        switch response.result {
                        case .success(let model):
                            print(model)
                            single(.success(model))
                        case .failure(let fail):
                            print(fail)
                            single(.failure(fail))
                        }
                    }
            } catch {
                
            }
            
            return Disposables.create()
        }
    }
}
