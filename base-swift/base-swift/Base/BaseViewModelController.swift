//
//  BaseViewModelController.swift
//  base-swift
//
//  Created by ThiemJason on 4/25/23.
//  Copyright © 2023 BaseSwift. All rights reserved.
//

import Foundation
import UIKit

class BaseViewModelController<T>: BaseViewController {
    private(set) var viewModel: T?
    
    init(_ viewModel: T?) {
        super.init()
        self.viewModel = viewModel
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func setupBinding() {
        super.setupBinding()
        if let viewModel = viewModel as? BaseViewModel {
            viewModel.rxLoading
                .distinctUntilChanged()
                .onMain()
                .subscribe(onNext: { [weak self] loading in
                    loading ? self?.showLoading() : self?.hideLoading()
                })
                .disposed(by: self.rxDisposeBag)
        }
    }
}
