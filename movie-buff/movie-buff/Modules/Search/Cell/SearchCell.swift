//
//  SearchCell.swift
//  movie-buff
//
//  Created by Prox on 27/04/2023.
//  Copyright © 2023 Prox. All rights reserved.
//

import UIKit

class SearchCell: UICollectionViewCell {
    static let nibName              = "SearchCell"
    @IBOutlet weak var vContent     : UIView!
    @IBOutlet weak var imgContent   : UIImageView!
    @IBOutlet weak var vSubcr       : UIView!
    @IBOutlet weak var lblSubcr     : UILabel!
    @IBOutlet weak var stvSubcr	    : UIStackView!
    @IBOutlet weak var lblType      : UILabel!
    @IBOutlet weak var lblSeason    : UILabel!
    @IBOutlet weak var lblYEar      : UILabel!
    @IBOutlet weak var vGap1        : UIView!
    @IBOutlet weak var vGap2        : UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.setupUI()
    }
    
    private func setupUI() {
        self.vContent.backgroundColor   = .clear
        self.vSubcr.backgroundColor     = .clear
        
        /** `Color` */
        self.lblSubcr.textColor         = .white
        self.lblType.textColor          = Constant.Color.hex_7A7A7A
        self.lblType.backgroundColor    = .black
        self.lblSeason.textColor        = Constant.Color.hex_7A7A7A
        self.lblSeason.backgroundColor  = .black
        self.lblYEar.textColor          = Constant.Color.hex_7A7A7A
        self.lblYEar.backgroundColor    = .black
        self.stvSubcr.backgroundColor   = .clear
        self.vGap1.backgroundColor      = Constant.Color.hex_7A7A7A
        self.vGap2.backgroundColor      = Constant.Color.hex_7A7A7A
        
        /** `Font` */
        self.lblSubcr.font              = BaseFont.System.text_bold
        self.lblYEar.font               = BaseFont.System.text_regular_subcr
        self.lblSeason.font             = BaseFont.System.text_regular_subcr
        self.lblType.font               = BaseFont.System.text_regular_subcr
    }
}
