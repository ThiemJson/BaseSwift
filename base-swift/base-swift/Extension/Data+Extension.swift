//
//  Data+Extension.swift
//  BaseSwift
//
//  Created by Macbook Pro 2017 on 7/8/20.
//  Copyright © 2020 Shantaram K. All rights reserved.
//

import Foundation
import SwiftyJSON

extension Encodable {
    func setParams() -> [String:Any] {
        var params: [String: Any] = [:]
        let data = try! JSONEncoder().encode(self)
        params = try! JSONSerialization.jsonObject(with: data, options: []) as! [String : Any]
        return params
    }
    func convertObjectToJson() -> JSON? {
        do {
            let data = try JSONEncoder().encode(self)
            let jsonData = try JSON.init(data: data)
            return jsonData
        } catch {
            return nil
        }
        
    }
}
