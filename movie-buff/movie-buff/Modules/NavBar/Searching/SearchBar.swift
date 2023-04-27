//
//  SearchBar.swift
//  movie-buff
//
//  Created by Prox on 27/04/2023.
//  Copyright © 2023 Prox. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class SearchBar: UIView {
    static let nibName              = "SearchBar"
    static let commonRatio          = CGFloat(50/673)
    
    @IBOutlet var mainView          : UIView!
    @IBOutlet weak var vBackground  : UIView!
    @IBOutlet weak var imgSearch    : UIImageView!
    @IBOutlet weak var imgDelete    : UIImageView!
    @IBOutlet weak var tfContent    : UITextField!
    
    let rxTextDidChange             = BehaviorRelay<String>.init(value: "")
    let rxDisposeBag                = DisposeBag()
    
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
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.vBackground.frame                  = self.bounds
        self.vBackground.layer.cornerRadius     = self.vBackground.frame.height / 2
        self.vBackground.clipsToBounds          = true
    }
    
    /** Init view */
    private func initializedView() {
        Bundle.main.loadNibNamed(SearchBar.nibName, owner: self, options: nil)
        self.addSubview(self.mainView)
        self.mainView.frame = self.bounds
        self.mainView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        
        /** `Background` */
        self.backgroundColor                = .clear
        
        /** `Icon` */
        self.imgDelete.image                = UIImage(systemName: BaseIcon.Search.cancel)
        self.imgSearch.image                = UIImage(systemName: BaseIcon.Search.search)
        self.imgDelete.tintColor            = Constant.Color.hex_7A7A7A
        self.imgSearch.tintColor            = Constant.Color.hex_7A7A7A
        
        /** `Text field` */
        self.tfContent.borderStyle          = .none
        self.tfContent.font                 = BaseFont.System.text_semibold
        self.tfContent.backgroundColor      = .clear
        self.tfContent.textColor            = .white
        self.tfContent.tintColor            = Constant.Color.hex_7A7A7A
        self.tfContent.attributedPlaceholder = NSAttributedString(
            string: "Search Movie, TVShow, Actor",
            attributes: [NSAttributedString.Key.foregroundColor: Constant.Color.hex_7A7A7A]
        )
        
        self.tfContent.addTarget(self,
                                 action: #selector(self.textFieldDidChange(_:)),
                                 for: .editingChanged)
        
        self.rxTextDidChange
            .asDriver()
            .drive(onNext: { [weak self] (text) in
                guard let `self` = self else { return }
                self.imgDelete.isHidden = text.isEmpty
            })
            .disposed(by: self.rxDisposeBag)
        
        self.imgDelete
            .rx.tap()
            .onMain()
            .subscribe(onNext: { [weak self] _ in
                guard let `self` = self else { return }
                self.tfContent.text         = ""
                self.imgDelete.isHidden     = true
            })
            .disposed(by: self.rxDisposeBag)
    }
}

extension SearchBar {
    @objc func textFieldDidChange(_ textField: UITextField) {
        self.rxTextDidChange.accept(textField.text ?? "")
    }
}
