//
//  UITableView+Extension.swift
//  movie-buff
//
//  Created by Prox on 27/04/2023.
//  Copyright © 2023 Prox. All rights reserved.
//

import Foundation
import UIKit

extension UITableView {
    func initDefault() {
        self.separatorStyle     = .none
        self.isScrollEnabled    = false
        self.showsVerticalScrollIndicator   = false
        self.showsHorizontalScrollIndicator = false
    }
}
