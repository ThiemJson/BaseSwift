//
//  BaseRouter+Execute.swift
//  BaseSwift
//
//  Created by ThiemJason on 24/03/2023.
//  Copyright © 2023 BaseSwift. All rights reserved.
//

import Alamofire

public class BaseResult<T> {
    public typealias ValueCallback<X> = ((X) -> Void)
    public typealias VoidCallback = (() -> Void)
    
    private var _onSuccess: ValueCallback<T>?
    private var _onError: ValueCallback<BaseResponse>?
    fileprivate var _onCompleted: VoidCallback?
    
    var value: T? {
        didSet {
            if let value = value {
                _onSuccess?(value)
            }
        }
    }
    
    var error: BaseResponse? {
        didSet {
            if let error = error {
                _onError?(error)
            }
        }
    }
    
    @discardableResult
    public func onSuccess(_ callback: @escaping ((T) -> Void)) -> Self {
        _onSuccess = callback
        return self
    }
    
    @discardableResult
    public func onError(_ callback: @escaping ((BaseResponse) -> Void)) -> Self {
        _onError = callback
        return self
    }
    
    @discardableResult
    public func onCompleted(_ callback: @escaping (() -> Void)) -> Self {
        _onCompleted = callback
        return self
    }
    
    // Call to ignore callback listener
    public func void() {}
}

extension BaseRouter {
    private func execute() -> BaseResult<BaseResponse> {
        let result = BaseResult<BaseResponse>()
        
        let startTime = Date().timeIntervalSince1970
        self.logRequest()
        BaseNetworkService.shared.sessionManager
            .request(self)
            .responseJSON(queue: .init(label: "BaseSwiftNetwork"), completionHandler: { (response) in
                defer { // Gọi cuối cùng của function
                    DispatchQueue.main.async {
                        result._onCompleted?()
                    }
                }
                
                self.log(response, startTime: startTime)
                
                let dataValue: Any? = response.value
                var responseObject = BaseResponse()
                responseObject.code = response.response?.statusCode
                responseObject.anyData = dataValue

                /**
                 {
                     "errorCode": 200,
                     "errorMessage": "",
                     "data": Any
                 }
                 Kiểm tra xem data trả về có phải format chung trước
                 */
                if let json = dataValue as? [String: Any], let object = BaseResponse.from(json: json), object.code != nil {
                    responseObject = object
                }
                
                //Xu ly response statusCode
                guard let statusCode = responseObject.code, BaseNetworkService.successStatusCodes.contains(statusCode) else {
                    // Truong hop bat buoc dang xuat
                    
                    //error
                    DispatchQueue.main.async {
                        result.error = responseObject
                    }
                    return
                }
                
                //Success
                DispatchQueue.main.async {
                    result.value = responseObject
                }
                return
            })
        
        return result
    }
    
    func object<T: Decodable>() -> BaseResult<T> {
        let result = BaseResult<T>()
        execute()
            .onSuccess { res in
                if let json = res.anyData as? [String: Any],
                   let data = try? JSONSerialization.data(withJSONObject: json),
                   let object = try? JSONDecoder().decode(T.self, from: data) {
                    return result.value = object
                }
                result.error = res
            }
            .onError { error in
                result.error = error
            }
            .onCompleted {
                result._onCompleted?()
            }
        return result
    }
    
    func array<T: Decodable>() -> BaseResult<[T]> {
        let result = BaseResult<[T]>()
        execute()
            .onSuccess { res in
                if let json = res.anyData as? [[String: Any]],
                   let data = try? JSONSerialization.data(withJSONObject: json),
                   let object = try? JSONDecoder().decode([T].self, from: data) {
                    return result.value = object
                }
                result.error = res
            }
            .onError { error in
                result.error = error
            }
            .onCompleted {
                result._onCompleted?()
            }
        return result
    }
    
    func raw<T>() -> BaseResult<T> {
        let result = BaseResult<T>()
        execute()
            .onSuccess { res in
                if let value = res.anyData as? T {
                    return result.value = value
                }
                result.error = res
            }
            .onError { error in
                result.error = error
            }
            .onCompleted {
                result._onCompleted?()
            }
        return result
    }
}

extension BaseRouter {
    private func logRequest() {
#if DEBUG
        
        let method = self.request.0
        let path = self.request.1
        
        let params = method == .get ? "" : "\n\nPARAMS"
        + "\n——————"
        + "\n\(self.prettyString(from: self.params))"
        
        let request = try? self.asURLRequest()
        BaseLog.d("------------------[LOG REQUEST]------------------"
                + "\n[REQUEST] \(method.rawValue) => \(request?.url?.absoluteString ?? (BaseRouter.baseURL + path))"
                
                + params
        )
#endif
    }
    
    private func log(_ response: AFDataResponse<Any>, startTime: Double) {
#if DEBUG
        //                    let responseString = object.toJSONString(prettyPrint: true)
        var responseString: String?
        var data: Data? = response.data
        if let json = response.value as? [String: Any] {
            do {
                data = try JSONSerialization.data(withJSONObject: json, options: .prettyPrinted)
            }
            catch {}
        }
        
        if let data = data {
            responseString = String(data: data, encoding: .utf8)
        }
        
        let method = self.request.0
//        let path = self.request.1
        
        let params = method == .get ? "" : "\n\nPARAMS"
        + "\n——————"
        + "\n\(self.prettyString(from: self.params))"
        BaseLog.d("\n------------------[LOG RESPONSE]------------------"
                + "\nTIME => \(Date().timeIntervalSince1970 - startTime)s"
                + "\n[RESPONSE] \(method.rawValue) => \(response.request?.url?.absoluteString ?? "")"
                
                + "\n\nHEADERS"
                + "\n———————"
                + "\n\(self.prettyString(from: response.request?.allHTTPHeaderFields))"
                
                + params
                
                + "\n\nRESPONSE"
                + "\n————————"
                + "\n\(responseString ?? "nil")"
        )
#endif
    }
    
    private func prettyString(from json: [String: Any]?) -> String {
        if let json = json {
            do {
                let data = try JSONSerialization.data(withJSONObject: json, options: .prettyPrinted)
                return String(data: data, encoding: .utf8) ?? "{}"
            }
            catch {}
        }
        return "{}"
    }
}
