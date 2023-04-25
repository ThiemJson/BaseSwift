//
//  BaseModel.swift
//  BaseSwift
//
//  Created by ThiemJason on 24/03/2023.
//  Copyright © 2023 BaseSwift. All rights reserved.
//

import Foundation

public class BaseModel: Codable {
    public required init() {}
    
    public class func from(json: [String: Any]) -> Self? {
        do {
            let data = try JSONSerialization.data(withJSONObject: json)
            let object = try JSONDecoder().decode(Self.self, from: data)
            return object
        } catch {
            debugPrint("\(NSStringFromClass(Self.self)) Parse json error:\n\(error)")
        }
        return nil
    }
}

extension BaseModel {
    public var json: [String: Any] {
        var json = [String: Any]()
        if let data = try? JSONEncoder().encode(self),
           let jsonObject = try? JSONSerialization.jsonObject(with: data) as? [String: Any]  {
            json = jsonObject
        }
        return json
    }
}
