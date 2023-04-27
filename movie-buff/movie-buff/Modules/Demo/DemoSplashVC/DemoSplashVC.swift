//
//  DemoSplashVC.swift
//  MovieBuff
//
//  Created by Prox on 25/04/2023.
//  Copyright © 2023 Prox. All rights reserved.
//

import UIKit

class DemoSplashVC: BaseViewModelController<DemoSplashVM> {
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let dashboardVC = RootTabbarVC()
        self.replaceRoot(to: dashboardVC, withTransitionType: .push, andTransitionSubtype: .fromRight)
        
        //        if let token = UserDefaultUtils.shared.getAccessToken(), token.isEmpty == false {
        //            let dashboardVC = RootTabbarVC()
        //            self.replaceRoot(to: dashboardVC, withTransitionType: .push, andTransitionSubtype: .fromRight)
        //        } else {
        //            let loginVC = DemoLoginVC(DemoLoginVMObject())
        //            self.replaceRoot(to: loginVC, withTransitionType: .push, andTransitionSubtype: .fromRight)
        //        }
    }
}
