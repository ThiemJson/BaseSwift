//
//  ValidationUtils.swift
//  base-swift
//
//  Created by ThiemJason on 24/04/2023.
//  Copyright © 2023 BaseSwift. All rights reserved.
//

import Foundation
extension String {
    var isValidContact: Bool {
        let phoneNumberRegex = "^[0]\\d{9}$"
        let phoneTest = NSPredicate(format: "SELF MATCHES %@", phoneNumberRegex)
        let isValidPhone = phoneTest.evaluate(with: self)
        return isValidPhone
    }
    public func isValidPassword() -> Bool {
        //        let passwordRegex = "^(?=.*\\d)(?=.*[a-z])(?=.*[A-Z])[0-9a-zA-Z!@#$%^&*()\\-_=+{}|?>.<,:;~`’]{8,}$"
        let passwordRegex = "^(?=.*[a-zA-Z])(?=.*[0-9]).{8,32}$"
        return NSPredicate(format: "SELF MATCHES %@", passwordRegex).evaluate(with: self)
    }
    
    public func isValidPasswordDevice() -> Bool {
        //        let passwordRegex = "^(?=.*\\d)(?=.*[a-z])(?=.*[A-Z])[0-9a-zA-Z!@#$%^&*()\\-_=+{}|?>.<,:;~`’]{8,}$"
        let passwordRegex = "^.{8,32}$"
        return NSPredicate(format: "SELF MATCHES %@", passwordRegex).evaluate(with: self)
    }
    
    public func isValidWaterMark() -> Bool {
        //        let passwordRegex = "^(?=.*\\d)(?=.*[a-z])(?=.*[A-Z])[0-9a-zA-Z!@#$%^&*()\\-_=+{}|?>.<,:;~`’]{8,}$"
        let passwordRegex = "^.{0,13}$"
        return NSPredicate(format: "SELF MATCHES %@", passwordRegex).evaluate(with: self)
    }
    
    public func isValidVersionNumber() -> Bool {
        /** Tên version chỉ cho phép có các kí tự 0-9 "."  "v" */
        let versionNameRegex = "^[v0-9][0-9.]*$"
        return NSPredicate(format: "SELF MATCHES %@", versionNameRegex).evaluate(with: self)
    }
    
    var isValid84Contact: Bool {
        let phoneNumberRegex = "^[84]\\d{10}$"
        let phoneTest = NSPredicate(format: "SELF MATCHES %@", phoneNumberRegex)
        let isValidPhone = phoneTest.evaluate(with: self)
        return isValidPhone
    }
    
    var isValidHour: Bool {
        if Int(self) ?? 0 >= 0 && Int(self) ?? 0 < 24 {
            return true
        } else {
            return false
        }
    }
    
    var isValidMinute: Bool {
        if Int(self) ?? 0 >= 0 && Int(self) ?? 0 < 60 {
            return true
        } else {
            return false
        }
    }
}
func matchesRegex(for regex: String, in text: String) -> [String] {
    do {
        let regex = try NSRegularExpression(pattern: regex,options:.caseInsensitive)
        let results = regex.matches(in: text,
                                    range: NSRange(location: 0, length: text.count))
        let finalResult = results.map {
            (text as NSString).substring(with: $0.range)
        }
        return finalResult
    } catch let error {
        print("error regex: \(error.localizedDescription)")
        return []
    }
}

func replaceRegex(for regex: String, in text: NSMutableString, temp: String) -> String {
    let regex = try? NSRegularExpression(pattern: regex,options:.caseInsensitive)
    regex?.replaceMatches(in: text, options: .reportProgress, range: NSRange(location: 0,length: text.length), withTemplate: temp)
    return text as String
}
