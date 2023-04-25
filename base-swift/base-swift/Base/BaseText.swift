//
//  BaseText.swift
//  base-swift
//
//  Created by ThiemJason on 24/04/2023.
//

import Foundation

struct BaseText {
    static var unknownError: String { dLocalized("KEY_UNKNOWN_ERROR") }
    static var networkError: String { dLocalized("KEY_DEFAULT_INTERNET_ERROR") }
    static var loading: String { dLocalized("KEY_LOADING") }
}
