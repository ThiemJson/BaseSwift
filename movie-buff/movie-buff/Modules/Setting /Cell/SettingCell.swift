//
//  SettingCell.swift
//  movie-buff
//
//  Created by Prox on 27/04/2023.
//  Copyright © 2023 Prox. All rights reserved.
//

import UIKit

class SettingCell: UITableViewCell {
    static let nibName              = "SettingCell"
    @IBOutlet weak var imgLeft      : UIImageView!
    @IBOutlet weak var imgRIght     : UIImageView!
    @IBOutlet weak var lblTitle     : UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.setupUI()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    private func setupUI() {
        self.imgLeft.tintColor      = .white
        self.imgRIght.tintColor     = .white
        self.lblTitle.textColor     = .white
    }
}
