//
//  AppMessagesManager.swift
//  BaseSwift
//
//  Created by mac on 6/26/20.
//  Copyright © 2020 Viet Anh Dang. All rights reserved.
//

import Foundation
import SwiftMessages
import RxCocoa
import RxSwift
import Toast_Swift

class AppMessagesManager {
    // Share instance
    static let shared = AppMessagesManager()
    // Seperate SwiftMessage instance to display multiple message at same time
    let successSwiftMessage = SwiftMessages()
    let timeSwiftMessage = SwiftMessages()
    let freeCastSwiftMessage = SwiftMessages()
    let commonMessageInstant = SwiftMessages()
    let reviewSwifMessage = SwiftMessages()
    
    let premiumSwiftMessage = SwiftMessages()
    let approachViewMessage = SwiftMessages()
    
    var sharedConfig: SwiftMessages.Config {
        var config = SwiftMessages.Config()
        config.presentationStyle = .bottom
        config.duration = .forever
        config.dimMode = .gray(interactive: true)
        config.interactiveHide = true
        config.preferredStatusBarStyle = .lightContent
        return config
    }
}


// MARK: - Message notify
extension AppMessagesManager {
    func showMessage(messageType type: Theme, withTitle title: String = "", message: String, isPresented: Bool? = nil,  completion: (() -> Void)? = nil, duration: SwiftMessages.Duration = .seconds(seconds: 4)) {
        
        if var topController = UIApplication.shared.keyWindow?.rootViewController {
            // Comment lại bởi vì dòng này gây ra lỗi khi hiện AppMessage
            if isPresented ?? false {
                if let presentedViewController = topController.presentedViewController {
                    topController = presentedViewController
                }
            }
            topController.view.endEditing(true)
            topController.view.hideToast()
            topController.view.makeToast(message)
            completion?()
        }
    }
    
    func showMessage(messageType type: Theme, withTitle title: String = "", message: String, completion: (() -> Void)? = nil, duration: SwiftMessages.Duration = .seconds(seconds: 4), config: SwiftMessages.Config) {
        
        if let topController = UIApplication.shared.keyWindow?.rootViewController {
            // Comment lại bởi vì dòng này gây ra lỗi khi hiện AppMessage
            //            while let presentedViewController = topController.presentedViewController {
            //                topController = presentedViewController
            //            }
            topController.view.endEditing(true)
            topController.view.hideToast()
            topController.view.makeToast(message)
            completion?()
        }
    }
    
    func showNoInternetConnection() {
        let viewID = "no-internet-connection"
        let currentView = SwiftMessages.current(id: viewID)
        // Guard message currently is not shown
        guard currentView == nil else { return }
        var config = SwiftMessages.Config()
        config.dimMode = .none
        config.presentationStyle = .top
        config.duration = .forever
        
        let view = MessageView.viewFromNib(layout: .statusLine)
        view.configureTheme(.error)
        view.configureContent(body: "Error connection")
        view.id = viewID
        SwiftMessages.sharedInstance.show(config: config, view: view)
    }
}
