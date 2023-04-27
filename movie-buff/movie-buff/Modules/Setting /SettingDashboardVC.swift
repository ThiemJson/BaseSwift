//
//  SettingDashboardVC.swift
//  movie-buff
//
//  Created by Prox on 27/04/2023.
//  Copyright © 2023 Prox. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class SettingDashboardVC: BaseViewModelController<SettingDashboardVM> {
    @IBOutlet weak var vNavBar          : NavBar!
    @IBOutlet weak var tbvContent       : UITableView!
    @IBOutlet weak var cNavBarHeight    : NSLayoutConstraint!
    
    override func setupUI() {
        self.setupTbv()
    }
    
    override func setupNavBar() {
        super.setupNavBar()
        self.vNavBar.imgRight.isHidden  = true
    }
    
    override func setupLocalizer() {
        super.setupLocalizer()
        self.languageModel.Setting.drive(self.vNavBar.lblTItle.rx.text).disposed(by: self.rxDisposeBag)
    }
    
    private func setupTbv() {
        self.tbvContent.register(UINib(nibName: SettingCell.nibName, bundle: nil), forCellReuseIdentifier: SettingCell.nibName)
        self.tbvContent.delegate        = self
        self.tbvContent.dataSource      = self
        self.tbvContent.backgroundColor = .clear
        self.tbvContent.initDefault()
    }
}

extension SettingDashboardVC : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SettingCell.nibName, for: indexPath) as? SettingCell else {
            return UITableViewCell()
        }
        
        switch indexPath.row {
        case 0: /** `Privacy` */
            cell.lblTitle.text  = dLocalized(BaseText.Setting.privacy)
            cell.imgLeft.image  = UIImage(systemName: BaseIcon.Setting.privacy)
            
        case 1: /** `Rating` */
            cell.lblTitle.text  = dLocalized(BaseText.Setting.rating)
            cell.imgLeft.image  = UIImage(systemName: BaseIcon.Setting.rating)
            
        case 2: /** `Share` */
            cell.lblTitle.text  = dLocalized(BaseText.Setting.share)
            cell.imgLeft.image  = UIImage(systemName: BaseIcon.Setting.share)
            
        case 3: /** `Feedback` */
            cell.lblTitle.text  = dLocalized(BaseText.Setting.feedback)
            cell.imgLeft.image  = UIImage(systemName: BaseIcon.Setting.feedback)
            
        default:
            break
        }
        
        cell.imgRIght.image     = UIImage(systemName: BaseIcon.Common.forward)
        cell.lblTitle.font      = BaseFont.System.text_semibold
        cell.backgroundColor    = .clear
        cell.selectionStyle     = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return self.tbvContent.frame.height * (50 / 655)
    }
}
