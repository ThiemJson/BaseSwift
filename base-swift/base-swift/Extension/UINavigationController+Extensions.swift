//
//  UINavigationController+Extensions.swift
//  BaseSwift
//
//  Created by ThiemJason on 16/03/2023.
//  Copyright © 2023 BaseSwift. All rights reserved.
//

import UIKit

extension UINavigationController {
    static var top: UINavigationController? {
        var navi: UINavigationController?
        var topController = UIApplication.shared.keyWindow?.rootViewController
        while true {
            if let tabBarController = topController as? UITabBarController {
                topController = tabBarController.selectedViewController
            }
            if let topController = topController as? UINavigationController {
                navi = topController
            }
            
            guard let presentedViewController = topController?.presentedViewController else {
                break
            }
            topController = presentedViewController
        }
        return navi
    }
}

extension UINavigationController {
    func removeControllers(of type: AnyClass) {
        var viewControllers = self.viewControllers
        viewControllers.removeAll(where: { $0.isKind(of: type) })
        self.viewControllers = viewControllers
    }
}
