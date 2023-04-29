//
//  FVPageTVShowVM.swift
//  movie-buff
//
//  Created by ThiemJason on 29/04/2023.
//  Copyright © 2023 Prox. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift

/** `Define` */
protocol FVPageTVShowVM : BaseViewModel {
    func fetch()
}

/** `Implement function` */
extension FVPageTVShowVM {
    func fetch() {
        print("=======> Fetch")
    }
}

/** `Implement Properties` */
class FVPageTVShowVMObject : BaseViewModelObject, FVPageTVShowVM {}
