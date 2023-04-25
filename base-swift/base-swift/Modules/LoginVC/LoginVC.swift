//
//  LoginVC.swift
//  base-swift
//
//  Created by ThiemJason on 4/25/23.
//  Copyright © 2023 BaseSwift. All rights reserved.
//

import UIKit

class LoginVC: BaseViewModelController<LoginVM> {
    override func viewDidLoad() {
        super.viewDidLoad()
        self.viewModel?.login(auth: AuthModel())
    }
}
