//
//  PingManager.swift
//  BaseSwift
//
//  Created by Macbook Pro 2017 on 15/04/2021.
//  Copyright © 2021 BaseSwift. All rights reserved.
//

import Foundation
import Alamofire
import RxSwift

class PingManager {
    static let shared = PingManager()
    var alamofireManager: Session?
    var isCooldown = false
    fileprivate let networkTimeout: TimeInterval = 5
    static let isConnect: PublishSubject<Bool> = PublishSubject()

    init() {
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = networkTimeout
        configuration.timeoutIntervalForResource = networkTimeout
        configuration.requestCachePolicy = .reloadIgnoringLocalCacheData

        alamofireManager = Session(configuration: configuration)
    }
    
    func checkInternetConnection(completionHandler: @escaping (_ isReachable:Bool) -> Void) {
        self.alamofireManager?.request("http://clients3.google.com/generate_204").response { response in
            let isReachable = [200, 204].contains(response.response?.statusCode)
            completionHandler(isReachable)
            PingManager.isConnect.onNext(isReachable)
        }
    }
    
    func rxPing() -> Observable<Bool> {
        return Observable.create { [weak self] observer in
            self?.checkInternetConnection(completionHandler: { isReachable in
                observer.onNext(isReachable)
            })
            return Disposables.create()
        }
    }
}
