//
//  BaseViewModel.swift
//  base-swift
//
//  Created by ThiemJason on 24/04/2023.
//

import UIKit
import RxSwift
import RxCocoa

protocol BaseViewModel {
    var rxDisposeBag    : DisposeBag            { get }
    var rxLoading       : BehaviorRelay<Bool>   { get }
}

class BaseViewModelObject: BaseViewModel {
    var rxDisposeBag    : DisposeBag            = DisposeBag()
    var rxLoading       : BehaviorRelay<Bool>   = .init(value: false)
    init() {}
}
