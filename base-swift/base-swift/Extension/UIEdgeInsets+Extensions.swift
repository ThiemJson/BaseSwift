//
//  UIEdgeInsets+Extensions.swift
//  BaseSwift
//
//  Created by ThiemJason on 13/03/2023.
//  Copyright © 2023 BaseSwift. All rights reserved.
//

import UIKit

extension UIEdgeInsets {
    static func edge(_ padding: CGFloat) -> UIEdgeInsets {
        return UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding)
    }
    
    static func only(top: CGFloat = .zero, left: CGFloat = .zero, bottom: CGFloat = .zero, right: CGFloat = .zero) -> UIEdgeInsets {
        return UIEdgeInsets(top: top, left: left, bottom: bottom, right: right)
    }
    
    init(horizontal: CGFloat = .zero, vertical: CGFloat = .zero) {
        self.init(top: vertical, left: horizontal, bottom: vertical, right: horizontal)
    }
}
