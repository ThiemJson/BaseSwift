//
//  HelperUtils.swift
//  base-swift
//
//  Created by ThiemJason on 25/04/2023.
//  Copyright © 2023 BaseSwift. All rights reserved.
//

import Foundation
import UIKit

struct HelperUtils {
    public static var isPad = Bool()
    public static var badgeCount = 0 {
        didSet {
            // Cập nhật lại số thông báo ở icon app ngoài màn hình ứng dụng
            UNUserNotificationCenter.current().requestAuthorization(options: .badge) { (granted, error) in
                if error != nil { return }
                DispatchQueue.main.async {
                    UIApplication.shared.applicationIconBadgeNumber =  HelperUtils.badgeCount
                }
            }
        }
    }
}
