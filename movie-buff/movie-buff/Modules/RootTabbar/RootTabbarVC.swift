//
//  RootTabbarVC.swift
//  movie-buff
//
//  Created by Prox on 27/04/2023.
//  Copyright © 2023 Prox. All rights reserved.
//

import UIKit

class RootTabbarVC: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupView()
        self.setupTabbar()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    private func setupView() {
        self.tabBar.barTintColor    = .white
        self.tabBar.isTranslucent   = false
        
        // Fix bug tabbar background color is turn black in iOS 15.0 or above
        if #available(iOS 15.0, *) {
            self.tabBar.barTintColor    = .primary
            self.tabBar.tintColor       = .white
        }
    }
    
    private func setupTabbar() {
        /** `Setting` */
        let settingVC = SettingDashboardVC(SettingDashboardVMObject()).embedInNavigationController()
        settingVC.tabBarItem.title = "SettingVC"
        
        /** `Search` */
        let searchVC = SearchDasboardVC(SearchDasboardVMObject()).embedInNavigationController()
        searchVC.tabBarItem.title = "SearchV"
        
        /** `Favorite` */
        let favoriteVC = FavoriteDashboardVC().embedInNavigationController()
        favoriteVC.tabBarItem.title = "FavoriteVC"
        
        /** `Selfie` */
        let selfieVC    = SelfieDashboardVC().embedInNavigationController()
        selfieVC.tabBarItem.title = "SelfieVC"
        
        /** `TVShow` */
        let tvShowVC    = TVShowDashboardVC().embedInNavigationController()
        tvShowVC.tabBarItem.title = "TVShowVC"

        /** `Movie` */
        let movieVC     = MovieDashboardVC().embedInNavigationController()
        movieVC.tabBarItem.title = "MovieVC"
        
        self.viewControllers  = [tvShowVC, searchVC, settingVC]
    }
}
