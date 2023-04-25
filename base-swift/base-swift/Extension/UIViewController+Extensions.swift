//
//  UIViewController+Extensions.swift
//  BaseSwift
//
//  Created by ThiemJason on 16/03/2023.
//  Copyright © 2023 BaseSwift. All rights reserved.
//

import UIKit

extension UIViewController {
    static var topViewController: UIViewController? {
        var topController = UIApplication.shared.keyWindow?.rootViewController
        while true {
            if let tabBarController = topController as? UITabBarController {
                topController = tabBarController.selectedViewController
            }
            if let top = topController as? UINavigationController {
                topController = top.topViewController
            }
            guard let presentedViewController = topController?.presentedViewController else {
                break
            }
            topController = presentedViewController
        }
        return topController
    }
}

// MARK: - Transitions
extension UIViewController {
    func push(from navigationController: UINavigationController? = UINavigationController.top, animated: Bool = true, fromLeft: Bool = false, completion: (()->Void)? = nil) {
        guard let navi = navigationController ?? UINavigationController.top else { return }
        CATransaction.setCompletionBlock(completion)
        
        let transition = CATransition()
        transition.duration = 0.3
        transition.isRemovedOnCompletion = true
        transition.type = .moveIn
        transition.subtype = fromLeft ? .fromLeft : .fromRight
        transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.default)
        navi.view.layer.removeAllAnimations()
        navi.view.layer.add(transition, forKey: nil)
        navi.pushViewController(self, animated: false)
    }
    
    func present(from viewController: UIViewController? = UINavigationController.top, animated: Bool = true, completion: (()->Void)? = nil) {
        var controller: UIViewController = self
        controller.modalPresentationStyle = .fullScreen
        if !controller.isKind(of: UINavigationController.self) {
            controller = UINavigationController(rootViewController: self)
        }
        let top = (viewController ?? UIViewController.topViewController)
        top?.present(controller, animated: animated, completion: completion)
    }
    
    //pop the controller from its navigationcontroller
    func pop(animated: Bool = true) {
        self.navigationController?.popViewController(animated: animated)
    }
}

extension UIViewController {
    func removeOldScreens() {
        guard let navi = self.navigationController else { return }
        
        var viewControllers = navi.viewControllers
        viewControllers.removeAll(where: { $0 is Self && $0 != self })
        navi.viewControllers = viewControllers
    }
    
    func embedInNavigationController() -> UINavigationController {
        let navigationController = UINavigationController(rootViewController: self)
        navigationController.isNavigationBarHidden = true
        return navigationController
    }
}
