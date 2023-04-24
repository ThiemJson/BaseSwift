//
//  UIButton+Extension.swift
//  BaseSwift
//
//  Created by Macbook Pro 2017 on 7/3/20.
//  Copyright © 2023 BaseProject. All rights reserved.
//

import UIKit
extension UIButton {
    func addCornerAndColor(color: UIColor, cornerRadius: CGFloat) -> UIButton {
        self.layer.cornerRadius = cornerRadius
        self.backgroundColor = color
        return self
    }
    
    func addImageInsets(top:CGFloat, left:CGFloat, bottom:CGFloat,right:CGFloat) -> UIButton {
        self.imageEdgeInsets = UIEdgeInsets(top: top, left: left, bottom: bottom, right: right)
        self.imageView?.contentMode = .scaleAspectFit
        return self
    }
    
    func turnOnButton() -> UIButton {
        self.isSelected = true
        self.setImage(UIImage(named: "Icon_log_in"), for: .normal)
        self.backgroundColor = Constant.Color.btn_on_color
        return self
    }
    
    func turnOffButton() -> UIButton {
        self.isSelected = false
        self.setImage(UIImage(named: "Icon_log_out"), for: .normal)
        self.backgroundColor = Constant.Color.btn_off_color
        return self
    }
    
    func rotate() -> UIButton {
        let rotation : CABasicAnimation = CABasicAnimation(keyPath: "transform.rotation.z")
        rotation.toValue = NSNumber(value: Double.pi * 2)
        rotation.duration = 1
        rotation.isCumulative = true
        rotation.repeatCount = Float.greatestFiniteMagnitude
        self.layer.add(rotation, forKey: "rotationAnimation")
        return self
    }
    
    func setBorderButton(_ tittle: String = "", _ color: UIColor = Constant.Color.hex_2D74E7) -> UIButton {
        self.layer.cornerRadius = self.frame.size.height/2
        self.backgroundColor = color
        if tittle != "" {
            self.setTitle(tittle, for: .normal)
        }
        return self
    }
    
    func addRightIcon(_ image: UIImage) {
        let imageView = UIImageView(image: image)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(imageView)
        let length = CGFloat(24)
        titleEdgeInsets.right += length
        
        NSLayoutConstraint.activate([
            imageView.leadingAnchor.constraint(equalTo: self.titleLabel!.trailingAnchor, constant: 10),
            imageView.centerYAnchor.constraint(equalTo: self.titleLabel!.centerYAnchor, constant: 0),
            imageView.widthAnchor.constraint(equalToConstant: length),
            imageView.heightAnchor.constraint(equalToConstant: length)
        ])
    }
}

extension UIButton {
    @discardableResult
    func image(_ image: UIImage, color: UIColor? = nil, state: UIControl.State = UIControl.State()) -> Self {
        if let color = color {
            setImage(image.withRenderingMode(.alwaysTemplate), for: state)
            imageView?.tintColor = color
        } else {
            setImage(image, for: state)
        }
        return self
    }
    
    @discardableResult
    func title(_ title: String, font: UIFont? = nil, color: UIColor? = nil, state: UIControl.State = UIControl.State()) -> Self {
        setTitle(title, for: state)
        if let font = font {
            titleLabel?.font = font
        }
        if let color = color {
            setTitleColor(color, for: state)
        }
        return self
    }
    
    @discardableResult
    func contentInsets(_ insets: UIEdgeInsets) -> Self {
        contentEdgeInsets = insets
        return self
    }
    
    @discardableResult
    func contentAlignment(vertical: UIControl.ContentVerticalAlignment = .center,
                          horizontal: UIControl.ContentHorizontalAlignment = .center) -> UIButton {
        contentVerticalAlignment = vertical
        contentHorizontalAlignment = horizontal
        return self
    }
}
