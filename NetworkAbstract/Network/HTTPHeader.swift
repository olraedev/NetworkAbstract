//
//  HTTPHeader.swift
//  NetworkAbstract
//
//  Created by SangRae Kim on 4/11/24.
//

import Foundation

enum HTTPHeader: String {
    case sesacKey = "SesacKey"
    case authorization = "Authorization"
    case contentType = "Content-Type"
    case json = "application/json"
    case formData = "multipart/form-data"
    case refresh = "Refresh"
}
