//
//  DemoLoginVM.swift
//  base-swift
//
//  Created by ThiemJason on 4/25/23.
//  Copyright © 2023 BaseSwift. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

protocol DemoLoginVM : BaseViewModel {
    var rxAuthModel: BehaviorRelay<BaseAuthModel?> { get }
    var rxError: BehaviorRelay<BaseResponse?> { get }
    
    func login(loginModel: BaseLoginModel)
    func register(regisModel: BaseRegistrationModel)
}

extension DemoLoginVM {
    func login(loginModel: BaseLoginModel) {
        self.rxLoading.accept(true)
        BaseAuthService.login(loginModel: loginModel)
            .onCompleted {
                self.rxLoading.accept(false)
            }
            .onSuccess { (baseAuthModel) in
                print("==> resoponse: \(baseAuthModel) ")
                self.rxAuthModel.accept(baseAuthModel)
            }
            .onError { baseResponse in
                self.rxError.accept(baseResponse)
            }
    }
    
    func register(regisModel: BaseRegistrationModel) {
        self.rxLoading.accept(true)
        BaseAuthService.register(regisModel: regisModel)
            .onCompleted {
                self.rxLoading.accept(false)
            }
            .onSuccess { (baseAuthModel) in
                self.rxAuthModel.accept(baseAuthModel)
            }
            .onError { baseResponse in
                self.rxError.accept(baseResponse)
            }
    }
}

class DemoLoginVMObject : BaseViewModelObject, DemoLoginVM {
    var rxAuthModel = RxRelay.BehaviorRelay<BaseAuthModel?>.init(value: nil)
    var rxError = RxRelay.BehaviorRelay<BaseResponse?>.init(value: nil)
}
