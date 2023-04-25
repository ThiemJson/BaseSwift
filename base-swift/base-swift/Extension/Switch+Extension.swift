//
//  Switch+Extension.swift
//  BaseSwift
//
//  Created by vuquangnam on 12/8/20.
//  Copyright © 2023 BaseProject. All rights reserved.
//

import UIKit
extension UISwitch {
    func setupSwitch(){
        self.tintColor = Constant.Color.hex_2D74E7
        self.thumbTintColor = UIColor.white
        self.backgroundColor = Constant.Color.hex_9EB6C3_op50
        self.onTintColor = Constant.Color.hex_2D74E7
        self.layer.cornerRadius = 16
        if HelperUtils.isPad {
            self.transform = CGAffineTransform(scaleX: 1, y: 1)
        }else{
            self.transform = CGAffineTransform(scaleX: 0.75, y: 0.75)
        }
    }
}
