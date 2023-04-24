//
//  Localizable.swift
//  BaseSwift
//
//  Created by ThiemJason on 16/4/23.
//  Copyright © 2023 BaseProject. All rights reserved.
//

import Foundation
import UIKit

let deLangVi = "vi"
let deLangEn = "en"

func dLocalized(_ key: String) -> String {
    let lang = UserDefaultUtils.shared.getAppLanguage() ?? deLangVi
    if let localizablePath = Bundle.main.path(forResource: "Localizable", ofType: "strings", inDirectory: nil, forLocalization: lang),
        let bundleUrl = NSURL(fileURLWithPath: localizablePath).deletingLastPathComponent {
        let bundle = Bundle(url: bundleUrl) ?? Bundle.main
        return NSLocalizedString(key, tableName: nil, bundle: bundle, value: "", comment: "")
    }
    return key
}
