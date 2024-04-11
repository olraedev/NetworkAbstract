//
//  LoginQuery.swift
//  NetworkAbstract
//
//  Created by SangRae Kim on 4/11/24.
//

import Foundation

struct LoginQuery: Encodable {
    let email: String
    let password: String
}
