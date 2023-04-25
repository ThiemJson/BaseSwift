//
//  OHRouter.swift
//  BaseSwift
//
//  Created by ThiemJason on 24/03/2023.
//  Copyright © 2023 BaseSwift. All rights reserved.
//

import Alamofire

enum BaseEndpoint : String {
    case login  = "/auth/login"
    case logout = "/auth/logout"
}

enum BaseRouter {
#if Develop
    static let baseURL = "https://dev-base.api.vn/api"
#elseif Staging
    static let baseURL = "https://staging-base.api.vn/api"
#else
    static let baseURL = "https://base.api.vn/api"
#endif
    
    /** `Auth` */
    case login(auth: AuthModel)
    case logout(token: String)
}

extension BaseRouter: URLRequestConvertible {
    // MARK: - Request Info
    var request: (HTTPMethod, String) {
        switch self {
        case .login(auth: _):
            return (.post, BaseEndpoint.login.rawValue)
        case .logout(token: let token):
            return (.post, "\(BaseEndpoint.logout.rawValue)/\(token)")
        }
    }
    
    //MARK: - Request Params
    /**
     ******************************************************************
     * Config Query & Body
     ******************************************************************
     */
    var params: [String: Any]? {
        switch self {
            /** `Auth` */
        case .login(auth: var auth):
            return auth.toJSON()
        default:
            return [:]
        }
    }
}

// MARK: - Request Define
extension BaseRouter {
    func asURLRequest() throws -> URLRequest {
        let url = try BaseRouter.baseURL.asURL()
        let method = request.0
        let path = request.1
        
        var urlRequest = URLRequest(url: url.appendingPathComponent(path))
        urlRequest.httpMethod = method.rawValue
        
        let jsonEncodingMethods: [HTTPMethod] = [.post, .put, .delete, .patch]
        let encoding: ParameterEncoding = jsonEncodingMethods.contains(method) ? JSONEncoding.default : URLEncoding.queryString
        urlRequest = try encoding.encode(urlRequest, with: params)
        return urlRequest
    }
}
