//
//  AuthModel.swift
//  base-swift
//
//  Created by ThiemJason on 4/25/23.
//  Copyright © 2023 BaseSwift. All rights reserved.
//

import Foundation

struct AuthModel : Codable {
    public var username: String?
    public var password: String?
    
    enum CodingKeys: String, CodingKey {
        case username = "username"
        case password = "password"
    }
    
    init() {}
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        username = try values.decodeIfPresent(String.self, forKey: .username)
        password = try values.decodeIfPresent(String.self, forKey: .password)
    }
    
    mutating func toJSON() -> [String: Any] {
        return self.convertObjectToJson()?.dictionaryObject ?? [:]
    }
}
