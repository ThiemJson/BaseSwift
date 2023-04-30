//
//  FVPageActorCell.swift
//  movie-buff
//
//  Created by ThiemJason on 30/04/2023.
//  Copyright © 2023 Prox. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class FVPageActorCell: UICollectionViewCell {
    static let nibName = "FVPageActorCell"
    @IBOutlet weak var vContentView : UIView!
    @IBOutlet weak var imgActor     : UIImageView!
    @IBOutlet weak var lblActor     : UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.setupUI()
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        self.vContentView.frame.size        = self.bounds.size
        self.imgActor.layer.cornerRadius    = self.imgActor.frame.height / 2
        self.imgActor.clipsToBounds         = true
    }
    
    private func setupUI() {
        self.vContentView.backgroundColor   = .clear
        self.backgroundColor                = .clear
        self.imgActor.contentMode           = .scaleToFill
        self.imgActor.layer.cornerRadius    = self.imgActor.frame.height / 2
        self.imgActor.clipsToBounds         = true
        self.lblActor.textColor             = .white
        self.lblActor.font                  = BaseFont.Libre.Cell.title
        self.lblActor.numberOfLines         = 3
    }
}
