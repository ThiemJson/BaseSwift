//
//  UserDefaultUtils.swift
//  BaseSwift
//
//  Created by Macbook Pro 2017 on 7/9/20.
//  Copyright © 2020 Shantaram K. All rights reserved.
//

import Foundation

enum UserDefaultsKey: String {
    case authExpires            = "authExpires-key"
    case authScope              = "authScope-key"
    case appCurrentLanguage     = "appCurrentLanguage"
    case authRefreshToken       = "authRefreshToken-key"
    case authTokenType          = "authTokenType-key"
    case authAccessToken        = "authAccessToken-key"
}

class UserDefaultUtils {
    
    static let shared = UserDefaultUtils()
    
    private var userDefault: UserDefaults = UserDefaults.standard
    
    func save<T>(key: UserDefaultsKey, value: T) {
        userDefault.set(value, forKey: key.rawValue)
        userDefault.synchronize()
    }
    
    func save<T>(key: String, value: T) {
        userDefault.set(value, forKey: key)
        userDefault.synchronize()
    }
    
    func get(key: UserDefaultsKey) -> Any? {
        return userDefault.value(forKey: key.rawValue)
    }
    
    func get(key: String) -> Any? {
        return userDefault.value(forKey: key)
    }
    
    func delete(key: UserDefaultsKey) {
        if self.userDefault.value(forKey: key.rawValue) != nil {
            self.userDefault.removeObject(forKey: key.rawValue)
        }
    }
    
    func delete(key: String) {
        if self.userDefault.value(forKey: key) != nil {
            self.userDefault.removeObject(forKey: key)
        }
    }
    
    func isValiAccessToken() -> Bool {
        guard let expired = get(key: .authExpires) as? Double else {
            return false
        }
        let dateFromExpired = Date(timeInterval: expired, since: Date(timeIntervalSince1970: expired))
        return fabs(dateFromExpired.timeIntervalSinceNow) > 86400
    }
    
    func getAccessTokenWithValidate() -> String? {
        guard let tokenType = getTokenType() else {
            return nil
        }
        
        guard let accessToken = getAccessToken() else {
            return nil
        }
        
        return "\(tokenType) \(accessToken)"
    }
    
    func getExpriesIn() -> TimeInterval? {
        return get(key: .authExpires) as? TimeInterval
    }
    
    func saveAppLanguage(language: String) {
        save(key: .appCurrentLanguage, value: language)
    }
    
    func getRefreshToken() -> String? {
        return get(key: .authRefreshToken) as? String
    }
    
    func getScope() -> String? {
        return get(key: .authScope) as? String
    }
    
    func getTokenType() -> String? {
        return get(key: .authTokenType) as? String
    }
    
    func saveAccessToken(token: String) {
        save(key: .authAccessToken, value: token)
    }
    
    func getAccessToken() -> String? {
        return get(key: .authAccessToken) as? String
    }
    
    func removeAccessToken() {
        delete(key: .authAccessToken)
    }
    
    func getAppLanguage() -> String? {
        return get(key: .appCurrentLanguage) as? String
    }
}
