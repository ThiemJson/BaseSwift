
//  LanguageModel.swift
//  MovieBuff
//
//  Created by Prox on 16/4/23.
//  Copyright © 2023 BaseProject. All rights reserved.


import RxCocoa
import RxLocalizer
import RxSwift

///```
/// `Sử dụng tại UIViewController`
///     override func setupLocalizer() {
///         super.setupLocalizer()
///         self.languageModel.Done.drive(self.btnDone.rx.title()).disposed(by: self.rxDisposeBag)
///     }
///```

protocol LanguageModelType {
    var changeLanguageTrigger: PublishRelay<String> { get }
    
    /** `Common` */
    var Ok          : Driver<String> { get }
    var Setting     : Driver<String> { get }
    var Done        : Driver<String> { get }
    var Cancel      : Driver<String> { get }
    var Move        : Driver<String> { get }
    var Save        : Driver<String> { get }
    var Agree       : Driver<String> { get }
    var Edit        : Driver<String> { get }
    var Delete      : Driver<String> { get }
    var Detail      : Driver<String> { get }
    
    /** `Setting` */
    var privacy     : Driver<String> { get }
    var rating      : Driver<String> { get }
    var share       : Driver<String> { get }
    var feedback    : Driver<String> { get }
}

class LanguageModel: LanguageModelType {
    public let langKey: PublishSubject<String> = PublishSubject()
    let changeLanguageTrigger = PublishRelay<String>()
    
    /** `Common` */
    let Ok          : Driver<String>
    let Setting     : Driver<String>
    let Done        : Driver<String>
    let Cancel      : Driver<String>
    let Move        : Driver<String>
    let Save        : Driver<String>
    let Agree       : Driver<String>
    let Edit        : Driver<String>
    let Delete      : Driver<String>
    let Detail      : Driver<String>
    
    /** `Setting` */
    let privacy     : Driver<String>
    let rating      : Driver<String>
    let share       : Driver<String>
    let feedback    : Driver<String>
    
    private let disposeBag = DisposeBag()
    
    public init(localizer: LocalizerType) {
        /** `Common` */
        Ok          = localizer.localized("KEY_ACT_OK")
        Done        = localizer.localized("KEY_ACT_DONE")
        Setting     = localizer.localized("KEY_ACT_SETTING")
        Cancel      = localizer.localized("KEY_ACT_CANCEL")
        Move        = localizer.localized("KEY_ACT_MOVE")
        Save        = localizer.localized("KEY_ACT_SAVE")
        Agree       = localizer.localized("KEY_ACT_AGREE")
        Edit        = localizer.localized("KEY_ACT_EDIT")
        Delete      = localizer.localized("KEY_ACT_DELETE")
        Detail      = localizer.localized("KEY_ACT_DETAIL")
        
        /** `Setting` */
        privacy     = localizer.localized("SETTING_PRIVACY")
        rating      = localizer.localized("SETTING_RATING")
        share       = localizer.localized("SETTING_SHARE")
        feedback    = localizer.localized("SETTING_FEEDBACK")
        
        changeLanguageTrigger.bind(to: localizer.changeLanguage).disposed(by: disposeBag)
    }
}
