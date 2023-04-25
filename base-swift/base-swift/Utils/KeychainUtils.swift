//
//  KeychainUtils.swift
//  base-swift
//
//  Created by ThiemJason on 4/25/23.
//  Copyright © 2023 BaseSwift. All rights reserved.
//

import Foundation
import KeychainAccess

public class KeychainUtils {
    public static func save(_ value : String, forKey key : String, inService service : String) {
        let keychain = Keychain(service: service)
        keychain[key] = value
    }
    
    public static func getValue(ForKey key : String, inService service : String) -> String? {
        let keychain = Keychain(service: service)
        return keychain[key]
    }
    
    public static func removeKey(_ key : String, inService service : String) {
        let keychain = Keychain(service: service)
        do {
            try keychain.remove(key)
        } catch let error {
            print("KeychainUtils error : \(error.localizedDescription)")
        }
    }
}
