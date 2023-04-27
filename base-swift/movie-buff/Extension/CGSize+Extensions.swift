//
//  CGSize+Extensions.swift
//  MovieBuff
//
//  Created by Prox on 15/03/2023.
//  Copyright © 2023 Prox. All rights reserved.
//

import UIKit

extension CGSize {
    static func square(_ size: CGFloat) -> CGSize {
        return CGSize(width: size, height: size)
    }
}
