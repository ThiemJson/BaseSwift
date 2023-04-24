//
//  ReactiveUIControl+Extension.swift
//  BaseSwift
//
//  Created by tam.dv on 04/05/2022.
//  Copyright © 2022 BaseSwift. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

extension Reactive where Base: UIControl {
    /// Bindable sink for `enabled` property.
    public var isEnabled: Binder<Bool> {
        return Binder(self.base) { control, value in
            control.isEnabled = value
            control.alpha = value ? 1.0 : 0.4
        }
    }
}
