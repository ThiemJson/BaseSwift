//
//  BaseAuthModel.swift
//  base-swift
//
//  Created by ThiemJason on 25/04/2023.
//  Copyright © 2023 BaseSwift. All rights reserved.
//

import Foundation
struct BaseAuthModel : Codable {
    public var id : Int?
    public var name : String?
    public var email : String?
    public var token : String?
    
    enum CodingKeys: String, CodingKey {
        case id = "Id"
        case name = "Name"
        case email = "Email"
        case token = "Token"
    }
    
    init() {}
    
    init(from decoder: Decoder) throws {
        let values  = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try? values.decodeIfPresent(Int.self, forKey: .id)
        self.name = try? values.decodeIfPresent(String.self, forKey: .name)
        self.email = try? values.decodeIfPresent(String.self, forKey: .email)
        self.token = try? values.decodeIfPresent(String.self, forKey: .token)
    }
    
    mutating func toJSON() -> [String: Any] {
        return self.convertObjectToJson()?.dictionaryObject ?? [:]
    }
}
