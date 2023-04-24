//
//  ReactiveTextfield+Extension.swift
//  BaseSwift
//
//  Created by Macbook Pro 2017 on 7/16/20.
//  Copyright © 2023 BaseProject. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

extension Reactive where Base: UITextField {
    var placeholder: Binder<String?> {
        return Binder(self.base) { taget, place in
            taget.placeholder = place
        }
    }
}

extension Reactive where Base: UITabBarItem {
    var title: Binder<String?> {
        return Binder(self.base) { taget, place in
            taget.title = place
        }
    }
}

extension Reactive where Base: UIBarButtonItem {
    var title: Binder<String?> {
        return Binder(self.base) { taget, place in
            taget.title = place
        }
    }
}
