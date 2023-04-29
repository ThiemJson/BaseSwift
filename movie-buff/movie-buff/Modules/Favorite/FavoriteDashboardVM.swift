//
//  FavoriteDashboardVM.swift
//  movie-buff
//
//  Created by ThiemJason on 4/28/23.
//  Copyright © 2023 Prox. All rights reserved.
//

import Foundation
/** `Define` */
protocol FavoriteDashboardVM : BaseViewModel {
    func fetchData()
}

/** `Implement function` */
extension FavoriteDashboardVM {
    func fetchData() {
        print("Fetch data")
    }
}

/** `Implement Properties` */
class FavoriteDashboardVMObject : BaseViewModelObject, FavoriteDashboardVM {}
