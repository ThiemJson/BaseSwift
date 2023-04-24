//
//  LanguageRespon.swift
//  BaseSwift
//
//  Created by ThiemJason on 24/4/23.
//  Copyright © 2023 BaseProject. All rights reserved.
//

import Foundation
import UIKit

func ErrorResonpose(key: String) -> String{
    switch key{
    case "error.common.timeout":
        return "KEY_ERROR_COMMON_TIMEOUT"
    default:
        return "KEY_MSG_CHANGE_FAIL"
    }
}
