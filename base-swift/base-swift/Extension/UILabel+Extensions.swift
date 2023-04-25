//
//  UILabel+Extensions.swift
//  BaseSwift
//
//  Created by ThiemJason on 16/03/2023.
//  Copyright © 2023 BaseSwift. All rights reserved.
//

import UIKit

extension UILabel {
    @discardableResult
    func text(_ text: String?) -> Self {
        self.text = text
        return self
    }
    
    @discardableResult
    func font(_ font: UIFont?) -> Self {
        self.font = font
        return self
    }
    
    @discardableResult
    func color(_ color: UIColor?) -> Self {
        self.textColor = color
        return self
    }
    
    @discardableResult
    func alignment(_ alignment: NSTextAlignment) -> Self {
        self.textAlignment = alignment
        return self
    }
    
    @discardableResult
    func numberOfLines(_ line: Int) -> Self {
        self.numberOfLines = line
        return self
    }
}
