//
//  BaseRequestInterceptor.swift
//  BaseSwift
//
//  Created by ThiemJason on 24/03/2023.
//  Copyright © 2023 BaseSwift. All rights reserved.
//

import Alamofire

class BaseRequestInterceptor: RequestInterceptor {
    private func initHeaders() -> HTTPHeaders {
        var headers = HTTPHeaders()
        if let accessToken = UserDefaultUtils.shared.getAccessToken() {
            headers["Authorization"] = "Bearer " + accessToken
        }
        return headers
    }
    
    func adapt(_ urlRequest: URLRequest, for session: Session, completion: @escaping (Result<URLRequest, Swift.Error>) -> Void) {
        var request = urlRequest
        request.allHTTPHeaderFields = initHeaders().dictionary
        completion(.success(request))
    }
    
    func retry(_ request: Request, for session: Session, dueTo error: Error, completion: @escaping (RetryResult) -> Void) {
        completion(.doNotRetry)
    }
}

