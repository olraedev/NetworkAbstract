//
//  JoinModel.swift
//  NetworkAbstract
//
//  Created by SangRae Kim on 4/11/24.
//

import Foundation

struct JoinModel: Decodable {
    let userID: String
    
    enum CodingKeys: String, CodingKey {
        case userID = "user_id"
    }
}
