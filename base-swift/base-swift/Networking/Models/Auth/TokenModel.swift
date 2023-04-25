//
//  TokenModel.swift
//  base-swift
//
//  Created by ThiemJason on 4/25/23.
//  Copyright © 2023 BaseSwift. All rights reserved.
//

import Foundation
struct TokenModel : Codable {
    public var token: String?
    
    enum CodingKeys: String, CodingKey {
        case token = "id_token"
    }
    
    init() {}
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        token = try values.decodeIfPresent(String.self, forKey: .token)
    }
}
