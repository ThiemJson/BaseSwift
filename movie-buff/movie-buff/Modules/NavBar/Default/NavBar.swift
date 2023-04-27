//
//  NavBar.swift
//  movie-buff
//
//  Created by Prox on 27/04/2023.
//  Copyright © 2023 Prox. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

enum NavBarType {
    case Default
    case Search
}

class NavBar: UIView {
    static let nibName              = "NavBar"
    static let commonRatio          = CGFloat(50/673)
    
    @IBOutlet var mainView          : UIView!
    @IBOutlet weak var imgLeftIcon  : UIImageView!
    @IBOutlet weak var imgRight     : UIImageView!
    @IBOutlet weak var lblTItle     : UILabel!
    @IBOutlet weak var vSearchBar   : SearchBar!
    
    let rxDisposeBag                = DisposeBag()
    let rxType                      = BehaviorRelay<NavBarType>.init(value: .Default)
    
    // MARK: Setting UI View
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.initializedView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.initializedView()
    }
    
    /** Init view */
    private func initializedView() {
        Bundle.main.loadNibNamed(NavBar.nibName, owner: self, options: nil)
        self.addSubview(self.mainView)
        self.mainView.frame = self.bounds
        self.mainView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        
        self.imgLeftIcon.tintColor  = .white
        self.lblTItle.textColor     = .white
        self.lblTItle.font          = UIFont.boldSystemFont(ofSize: HelperUtils.isPad ? 24 : 22)
        self.imgLeftIcon.image      = UIImage(systemName: BaseIcon.Common.backward)
        
        self.rxType.asDriver()
            .drive(onNext: { [weak self] (type) in
                guard let `self` = self else { return }
                switch type {
                case .Default:
                    self.vSearchBar.isHidden    = true
                case .Search:
                    self.vSearchBar.isHidden    = false
                    self.lblTItle.isHidden      = true
                default:
                    break
                }
                self.layoutSubviews()
            })
            .disposed(by: self.rxDisposeBag)
    }
}
