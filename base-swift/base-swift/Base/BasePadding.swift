//
//  BasePadding.swift
//  base-swift
//
//  Created by ThiemJason on 24/04/2023.
//

import Foundation
import UIKit

/**
 Khoảng cách giữa các Views
 */
struct BasePadding {
    static let small        : CGFloat = 4
    static let doubleSmall  : CGFloat = 8
    static let normal       : CGFloat = 12
    static let doubleNormal : CGFloat = 24
    static let large        : CGFloat = 16
    static let doubleLarge  : CGFloat = 32
}

// Extension Padding cho CGFloat
extension CGFloat {
    static let small        = BasePadding.small           // 4
    static let doubleSmall  = BasePadding.doubleSmall     // 8
    static let normal       = BasePadding.normal          // 12
    static let doubleNormal = BasePadding.doubleNormal    // 24
    static let large        = BasePadding.large           // 16
    static let doubleLarge  = BasePadding.doubleLarge     // 32
}
