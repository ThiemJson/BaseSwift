//
//  BaseNetworkService.swift
//  BaseSwift
//
//  Created by ThiemJason on 24/03/2023.
//  Copyright © 2023 BaseSwift. All rights reserved.
//

import Alamofire

open class BaseNetworkService {
    public static let shared = BaseNetworkService()
    public var sessionManager = Session.default
    public static let successStatusCodes: [Int] = [200, 0]
    
    private lazy var userAgent = initUserAgent()
    
    init() {
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 30
        configuration.timeoutIntervalForResource = 120
        configuration.requestCachePolicy = .reloadIgnoringLocalCacheData
        configuration.httpAdditionalHeaders = ["User-Agent": self.userAgent]
        self.sessionManager = Session(configuration: configuration, interceptor: BaseRequestInterceptor())
    }
}

extension BaseNetworkService {
    private func initUserAgent() -> String {
        let bundleId = Bundle.main.bundleIdentifier ?? ""
        let appVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] ?? ""
        let buildNumber = Bundle.main.infoDictionary?["CFBundleVersion"] ?? ""
        let device = UIDevice.current
        let model = device.model
        let systemName = device.systemName
        let systemVersion = device.systemVersion
        
        return "ios/\(bundleId)/\(appVersion)(\(buildNumber)) \(model)/\(systemName) \(systemVersion)"
    }
}
