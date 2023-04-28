//
//  BaseLoadingCell.swift
//  movie-buff
//
//  Created by ThiemJason on 4/28/23.
//  Copyright © 2023 Prox. All rights reserved.
//

import UIKit

class BaseLoadingCell: UICollectionReusableView {
    static let nibName                  = "BaseLoadingCell"
    var activityIndicator               = UIActivityIndicatorView()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.addSubview(self.activityIndicator)
        self.activityIndicator.translatesAutoresizingMaskIntoConstraints    = false
        NSLayoutConstraint.activate([
            self.activityIndicator.widthAnchor.constraint(equalToConstant: 30),
            self.activityIndicator.heightAnchor.constraint(equalToConstant: 30),
            self.activityIndicator.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            self.activityIndicator.centerYAnchor.constraint(equalTo: self.centerYAnchor),
        ])
    }
}
