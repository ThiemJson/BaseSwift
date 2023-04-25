
//  LanguageModel.swift
//  BaseSwift
//
//  Created by ThiemJason on 16/4/23.
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
    var Ok: Driver<String> { get }
    var Done: Driver<String> { get }
    var Cancel: Driver<String> { get }
    var Move: Driver<String> { get }
    var Save: Driver<String> { get }
    var Agree: Driver<String> { get }
    var Edit: Driver<String> { get }
    var Delete: Driver<String> { get }
    var Detail: Driver<String> { get }
    var changeLanguageTrigger: PublishRelay<String> { get }
}

class LanguageModel: LanguageModelType {
    public let langKey: PublishSubject<String> = PublishSubject()
    let Ok: Driver<String>
    let Done: Driver<String>
    let Cancel: Driver<String>
    let Move: Driver<String>
    let Save: Driver<String>
    let Agree: Driver<String>
    let Edit: Driver<String>
    let Delete: Driver<String>
    let Detail: Driver<String>
    let changeLanguageTrigger = PublishRelay<String>()

    private let disposeBag = DisposeBag()

    public init(localizer: LocalizerType) {
        Ok = localizer.localized("KEY_ACT_OK")
        Done = localizer.localized("KEY_ACT_DONE")
        Cancel = localizer.localized("KEY_ACT_CANCEL")
        Move = localizer.localized("KEY_ACT_MOVE")
        Save = localizer.localized("KEY_ACT_SAVE")
        Agree = localizer.localized("KEY_ACT_AGREE")
        Edit = localizer.localized("KEY_ACT_EDIT")
        Delete = localizer.localized("KEY_ACT_DELETE")
        Detail = localizer.localized("KEY_ACT_DETAIL")
        changeLanguageTrigger.bind(to: localizer.changeLanguage).disposed(by: disposeBag)
    }
}
