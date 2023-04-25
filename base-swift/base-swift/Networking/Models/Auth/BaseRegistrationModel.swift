//
//  RegistrationModel.swift
//  base-swift
//
//  Created by ThiemJason on 25/04/2023.
//  Copyright © 2023 BaseSwift. All rights reserved.
//

import Foundation
struct BaseRegistrationModel : Codable {
    public var name         : String?
    public var email        : String?
    public var password     : String?
    
    enum CodingKeys: String, CodingKey {
        case name           = "name"
        case email          = "email"
        case password       = "password"
    }
    
    init() {}
    
    init(from decoder: Decoder) throws {
        let values  = try decoder.container(keyedBy: CodingKeys.self)
        name        = try values.decodeIfPresent(String.self, forKey: .name)
        password    = try values.decodeIfPresent(String.self, forKey: .password)
        email       = try values.decodeIfPresent(String.self, forKey: .email)
    }
    
    mutating func toJSON() -> [String: Any] {
        return self.convertObjectToJson()?.dictionaryObject ?? [:]
    }
}
