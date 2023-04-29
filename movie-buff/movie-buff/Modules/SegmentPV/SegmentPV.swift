//
//  SegmentPV.swift
//  movie-buff
//
//  Created by ThiemJason on 4/28/23.
//  Copyright © 2023 Prox. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

enum SegmentSelected {
    case item1
    case item2
    case item3
}

class SegmentPV: UIView {
    static let nibName      = "SegmentPV"
    static let indexMapper  = [ SegmentSelected.item1 : 0,
                                SegmentSelected.item2 : 1,
                                SegmentSelected.item3 : 2 ]
    
    @IBOutlet var mainView              : UIView!
    @IBOutlet weak var vContentView     : UIView!
    
    /** `Item1`  */
    @IBOutlet weak var vItem1           : UIView!
    @IBOutlet weak var lblItem1         : UILabel!
    
    /** `Item 2` */
    @IBOutlet weak var vItem2           : UIView!
    @IBOutlet weak var lblItem2         : UILabel!
    
    /** `Item 3` */
    @IBOutlet weak var vItem3           : UIView!
    @IBOutlet weak var lblItem3         : UILabel!
    
    /** `Gap` */
    @IBOutlet weak var vGap             : UIView!
    
    let rxSegmentSelected               = BehaviorRelay<SegmentSelected>.init(value: .item1)
    let rxDisposeBag                    = DisposeBag()
    
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
        self.vGap.layer.cornerRadius    = self.vGap.frame.height / 2
        self.vGap.clipsToBounds         = true
    }
    
    /** Init view */
    private func initializedView() {
        Bundle.main.loadNibNamed(SegmentPV.nibName, owner: self, options: nil)
        self.addSubview(self.mainView)
        self.mainView.frame = self.bounds
        self.mainView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        self.vContentView.backgroundColor   = .clear
        
        /** `Text` */
        self.lblItem1.textColor     = .white
        self.lblItem2.textColor     = .white
        self.lblItem3.textColor     = .white
        self.lblItem1.font          = UIFont.mediumTitle
        self.lblItem2.font          = UIFont.mediumTitle
        self.lblItem3.font          = UIFont.mediumTitle
        
        /** `Item1` */
        self.vItem1
            .rx.tap()
            .asObservable()
            .onMain()
            .subscribe(onNext: { [weak self] _ in
                guard let `self` = self else { return }
                self.rxSegmentSelected.accept(.item1)
            })
            .disposed(by: self.rxDisposeBag)
        
        /** `Item3` */
        self.vItem3
            .rx.tap()
            .asObservable()
            .onMain()
            .subscribe(onNext: { [weak self] _ in
                guard let `self` = self else { return }
                self.rxSegmentSelected.accept(.item3)
            })
            .disposed(by: self.rxDisposeBag)
        
        /** `Item2` */
        self.vItem2
            .rx.tap()
            .asObservable()
            .onMain()
            .subscribe(onNext: { [weak self] _ in
                guard let `self` = self else { return }
                self.rxSegmentSelected.accept(.item2)
            })
            .disposed(by: self.rxDisposeBag)
        
        /** `Segment` */
        self.rxSegmentSelected
            .asDriver()
            .drive(onNext: { [weak self] (type) in
                guard let `self` = self else { return }
                UIView.animateKeyframes(withDuration: 0.2, delay: 0, options: .allowUserInteraction, animations: { [weak self] in
                    guard let `self` = self else { return }
                    var x = self.vGap.frame.origin.x
                    
                    /** `Color` */
                    self.lblItem2.textColor = Constant.Color.hex_7A7A7A
                    self.lblItem1.textColor = Constant.Color.hex_7A7A7A
                    self.lblItem3.textColor = Constant.Color.hex_7A7A7A
                    
                    switch type {
                    case .item1:
                        x = self.vItem1.center.x - self.vGap.frame.width / 2
                        self.lblItem1.textColor = .white
                    case .item2:
                        x = self.vItem2.center.x - self.vGap.frame.width / 2
                        self.lblItem2.textColor = .white
                    case .item3:
                        x = self.vItem3.center.x - self.vGap.frame.width / 2
                        self.lblItem3.textColor = .white
                    default:
                        break
                    }
                    self.vGap.frame.origin.x    = x
                }, completion: nil)
            })
            .disposed(by: self.rxDisposeBag)
    }
}
