//
//  SplashVM.swift
//  base-swift
//
//  Created by ThiemJason on 4/25/23.
//  Copyright © 2023 BaseSwift. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift

protocol SplashVM : BaseViewModel {}

extension SplashVM {}

class SplashVMObject : BaseViewModelObject, SplashVM {}
