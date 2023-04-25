//
//  OHRouter.swift
//  BaseSwift
//
//  Created by ThiemJason on 24/03/2023.
//  Copyright © 2023 BaseSwift. All rights reserved.
//

import Alamofire
/**
 This API from https://www.appsloveworld.com/sample-rest-api-url-for-testing-with-authentication
 */
enum BaseEndpoint : String {
    /** `Auth` */
    case register   = "/authaccount/registration"
    case login      = "/authaccount/login"
    
    /** `User` */
    case user       = "/users"
}

enum BaseRouter {
#if Develop
    static let domain  = "restapi.adequateshop.com"
    static let baseURL = "http://\(domain)/api"
#elseif Staging
    static let domain  = "restapi.adequateshop.com"
    static let baseURL = "http://\(domain)/api"
#else
    static let domain  = "restapi.adequateshop.com"
    static let baseURL = "http://\(domain)/api"
#endif
    
    /** `Auth` */
    case register(regisModel: BaseRegistrationModel)
    case login(loginModel: BaseLoginModel)
}

extension BaseRouter: URLRequestConvertible {
    // MARK: - Request Info
    var request: (HTTPMethod, String) {
        switch self {
            /** `Auth` */
        case .register(regisModel: _):
            return (.post, BaseEndpoint.register.rawValue)
        case .login(loginModel: _):
            return (.post, BaseEndpoint.login.rawValue)
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
        case .register(regisModel: var regisModel):
            return regisModel.toJSON()
        case .login(loginModel: var loginModel):
            return loginModel.toJSON()
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
