//
//  DemoDashboardVC.swift
//  MovieBuff
//
//  Created by Prox on 25/04/2023.
//  Copyright © 2023 Prox. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class DemoDashboardVC: BaseViewModelController<DemoDashboardVM> {
    @IBOutlet weak var btnLogout: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func handlerAction() {
        super.handlerAction()
        self.btnLogout.rx
            .tapWithNetwork()
            .subscribe(onNext: { [weak self] _ in
                guard let `self` = self else { return }
                
                /** `Delete token`  */
                UserDefaultUtils.shared.removeAccessToken()
                
                /** `Navigate to Login` */
                let loginVC = DemoLoginVC(DemoLoginVMObject())
                self.replaceRoot(to: loginVC, withTransitionType: .moveIn , andTransitionSubtype: .fromLeft)
            })
            .disposed(by: self.rxDisposeBag)
    }
}
