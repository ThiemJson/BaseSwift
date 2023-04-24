//
//  UIBarButtonItem.swift
//  BaseSwift
//
//  Created by Macbook Pro 2017 on 7/10/20.
//  Copyright © 2020 Shantaram K. All rights reserved.
//

import UIKit
extension UIBarButtonItem {

    static func menuButton(_ target: Any?, action: Selector, imageName: String, height:  CGFloat, width: CGFloat, rightSpacing: CGFloat) -> UIBarButtonItem {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: imageName)?.withRenderingMode(.alwaysOriginal), for: .normal)
        button.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: rightSpacing)
        button.addTarget(target, action: action, for: .touchUpInside)
        
        
        let menuBarItem = UIBarButtonItem(customView: button)
        menuBarItem.customView?.translatesAutoresizingMaskIntoConstraints = false
        
        menuBarItem.customView?.heightAnchor.constraint(equalToConstant: height).isActive = true
        menuBarItem.customView?.widthAnchor.constraint(equalToConstant: width).isActive = true

        return menuBarItem
    }
}
