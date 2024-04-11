//
//  LoginModel.swift
//  NetworkAbstract
//
//  Created by SangRae Kim on 4/11/24.
//

import Foundation

struct LoginModel: Decodable {
    let accessToken: String
    let refreshToken: String
}
