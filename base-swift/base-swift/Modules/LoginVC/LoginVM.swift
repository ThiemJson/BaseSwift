//
//  LoginVM.swift
//  base-swift
//
//  Created by ThiemJason on 4/25/23.
//  Copyright © 2023 BaseSwift. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

protocol LoginVM : BaseViewModel {
    var rxTokenModel: BehaviorRelay<TokenModel?> { get }
    func login(auth: AuthModel)
}

extension LoginVM {
    internal func login(auth: AuthModel) {
        self.rxLoading.accept(true)
        AuthService
            .login(authModel: auth)
            .onCompleted {
                self.rxLoading.accept(false)
            }
            .onSuccess { (result) in
                self.rxTokenModel.accept(result)
            }
            .onError { (baseResponse) in
                print("status: \(baseResponse.code ?? 0)")
            }
    }
}

class LoginVMObject : BaseViewModelObject, LoginVM {
    var rxTokenModel = RxRelay.BehaviorRelay<TokenModel?>.init(value: nil)
}
