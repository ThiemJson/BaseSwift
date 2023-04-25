//
//  DemoSplashVC.swift
//  base-swift
//
//  Created by ThiemJason on 25/04/2023.
//  Copyright © 2023 BaseSwift. All rights reserved.
//

import UIKit

class DemoSplashVC: BaseViewModelController<DemoSplashVM> {
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if let token = UserDefaultUtils.shared.getAccessToken(), token.isEmpty == false {
            let dashboardVC = DemoDashboardVC(DemoDashboardVMObject())
            self.replaceRoot(to: dashboardVC)
        } else {
            let loginVC = DemoLoginVC(DemoLoginVMObject())
            self.replaceRoot(to: loginVC)
        }
    }
}
