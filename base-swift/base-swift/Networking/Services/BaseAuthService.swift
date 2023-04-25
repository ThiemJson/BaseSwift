//
//  BaseAuthService.swift
//  base-swift
//
//  Created by ThiemJason on 4/25/23.
//  Copyright © 2023 BaseSwift. All rights reserved.
//

/**
 Ví dụ:
 ```
 self.rxLoading.accept(true)
 
 // Khai báo API
 OHMeshService.deviceDetail(id: id)
 
 // Trả về cả khi Thành công hoặc lỗi
 .onCompleted {
 self.rxLoading.accept(false)
 }
 
 // Khi cần lấy dữ liệu khi lỗi
 .onError { error in
 print(error.message ?? "")
 }
 
 // Khi cần lấy dữ liệu khi thành công
 .onSuccess { device in
 guard let nodes = device.igateProperties?.topoInfo else {
 return
 }
 self.devices.accept(
 nodes
 .sorted(by: { (a, b) in a.nodeRole == "CAP" || a.nodeRole?.hasPrefix("ONT") == true })
 .map({ OHWifiDeviceViewModelObject(info: $0) })
 )
 }
 ```
 */

import Foundation
public class BaseAuthService {
    static func register(regisModel: BaseRegistrationModel) -> BaseResult<BaseAuthModel> {
        return BaseRouter.register(regisModel: regisModel).object()
    }
    static func login(loginModel: BaseLoginModel) -> BaseResult<BaseAuthModel> {
        return BaseRouter.login(loginModel: loginModel).object()
    }
}
