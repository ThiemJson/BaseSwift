//
//  SearchDasboardVC.swift
//  movie-buff
//
//  Created by Prox on 27/04/2023.
//  Copyright © 2023 Prox. All rights reserved.
//

import UIKit

class SearchDasboardVC: BaseViewModelController<SearchDasboardVM> {
    @IBOutlet weak var vNavBar  : NavBar!
    
    override func setupNavBar() {
        super.setupNavBar()
        self.vNavBar.rxType.accept(.Search)
    }
    
    override func setupUI() {
        super.setupUI()
        self.view.backgroundColor   = .clear
    }
}
 
