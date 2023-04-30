//
//  FvPageMovieCell.swift
//  movie-buff
//
//  Created by ThiemJason on 30/04/2023.
//  Copyright © 2023 Prox. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class FvPageMovieCell: UICollectionViewCell {
    
    static let nibName = "FvPageMovieCell"
    @IBOutlet weak var vContent     : UIView!
    @IBOutlet weak var imgContent   : UIImageView!
    @IBOutlet weak var lblContent   : UILabel!
    @IBOutlet weak var lblType      : UILabel!
    @IBOutlet weak var lblSeason    : UILabel!
    @IBOutlet weak var lblYear      : UILabel!
    @IBOutlet weak var stvSubcr     : UIStackView!
    @IBOutlet weak var vGap1        : UIView!
    @IBOutlet weak var vGap2        : UIView!
    @IBOutlet weak var imgHeart     : UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.setupUI()
    }

    private func setupUI() {
        self.vContent.backgroundColor   = .clear
        self.imgHeart.tintColor         = UIColor.baseOrange
        
        /** `Color` */
        self.lblContent.textColor       = .white
        self.lblType.textColor          = Constant.Color.gray_white
        self.lblType.backgroundColor    = .black
        self.lblSeason.textColor        = Constant.Color.gray_white
        self.lblSeason.backgroundColor  = .black
        self.lblYear.textColor          = Constant.Color.gray_white
        self.lblYear.backgroundColor    = .black
        self.stvSubcr.backgroundColor   = .clear
        self.vGap1.backgroundColor      = Constant.Color.gray_white
        self.vGap2.backgroundColor      = Constant.Color.gray_white
        
        /** `Font` */
        self.lblContent.font            = BaseFont.Libre.Cell.title
        self.lblYear.font               = BaseFont.Libre.Cell.caption
        self.lblSeason.font             = BaseFont.Libre.Cell.caption
        self.lblType.font               = BaseFont.Libre.Cell.caption
    }
}
