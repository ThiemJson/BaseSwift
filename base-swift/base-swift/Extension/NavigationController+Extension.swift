//
//  NavigationController+Extension.swift
//  BaseSwift
//
//  Created by Macbook Pro 2017 on 10/13/20.
//  Copyright © 2023 BaseProject. All rights reserved.
//

import UIKit
extension UINavigationController {
  func popToViewController(ofClass: AnyClass, animated: Bool = true) {
    if let vc = viewControllers.last(where: { $0.isKind(of: ofClass) }) {
      popToViewController(vc, animated: animated)
    }
  }
}
