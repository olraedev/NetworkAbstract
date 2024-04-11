//
//  Router.swift
//  NetworkAbstract
//
//  Created by SangRae Kim on 4/11/24.
//

import Foundation
import Alamofire

enum Router {
    case join(query: JoinQuery)
    case login(query: LoginQuery)
    case withDraw
    case refreshToken
}

extension Router: TargetType {
    var baseURL: String { return APIKey.baseURL }
    
    var method: HTTPMethod {
        switch self {
        case .join, .login: .post
        case .withDraw, .refreshToken: .get
        }
    }
    
    var path: String {
        switch self {
        case .join: "/v1/users/join"
        case .login: "/v1/users/login"
        case .withDraw: "/v1/users/withdraw"
        case .refreshToken: "/auth/refresh"
        }
    }
    
    var header: [String : String] {
        switch self {
        case .join, .login:
            [HTTPHeader.contentType.rawValue: HTTPHeader.json.rawValue,
             HTTPHeader.sesacKey.rawValue: APIKey.secretKey]
        case .withDraw:
            [HTTPHeader.authorization.rawValue: UserDefaults.standard.string(forKey: "accessToken")!,
             HTTPHeader.sesacKey.rawValue: APIKey.secretKey]
        case .refreshToken:
            [HTTPHeader.authorization.rawValue: UserDefaults.standard.string(forKey: "accessToken")!,
             HTTPHeader.refresh.rawValue: UserDefaults.standard.string(forKey: "refreshToken")!,
             HTTPHeader.sesacKey.rawValue: APIKey.secretKey]
        }
    }
    
    var parameters: String? {
        return nil
    }
    
    var queryItems: [URLQueryItem]? {
        return nil
    }
    
    var body: Data? {
        switch self {
        case .join(let query):
            let encoder = JSONEncoder()
            encoder.keyEncodingStrategy = .convertToSnakeCase
            return try? encoder.encode(query)
        case .login(let query):
            let encoder = JSONEncoder()
            encoder.keyEncodingStrategy = .convertToSnakeCase
            return try? encoder.encode(query)
        default: return nil
        }
    }
}
