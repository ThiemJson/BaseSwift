//
//  BaseLogger.swift
//  BaseSwift
//
//  Created by ThiemJason on 24/03/2023.
//  Copyright © 2023 BaseSwift. All rights reserved.
//

import UIKit

open class BaseLog: NSObject {
    public enum BaseLogLevel: Int {
        case none
        case verbose
        case data
        case error
        case info
    }
    
    public static let shared = BaseLog()
    
    private let logThread: DispatchQoS.QoSClass = .utility
    private var appName: String
    open var logLevel: BaseLogLevel = .none
    
    public init(appName: String = "Base", level: BaseLogLevel = .verbose) {
        self.appName = appName
        self.logLevel = level
        super.init()
    }
    
    open func setNoneLevel() {
        logLevel = .none
    }
    
    open func setVerboseLevel() {
        logLevel = .verbose
    }
    
    open func setDataLevel() {
        logLevel = .data
    }
    
    open func setErrorLevel() {
        logLevel = .error
    }
    
    open func setInfoLevel() {
        logLevel = .info
    }
    
    open func logVerbose(_ format: Any?) {
        v(format)
    }
    
    open func logData(_ format: Any?) {
        d(format)
    }
    
    open func logError(_ format: Any?) {
        e(format)
    }
    
    open func logInfo(_ format: Any?) {
        i(format)
    }
    
    /// Log all
    open func v(_ item: Any?) {
        if logLevel != .none {
            DispatchQueue.global(qos: logThread).async {
                print("\n[LOG]---\(self.appName)---\n\(item != nil ? item! : "nil")\n")
            }
        }
    }
    
    /// Log data
    open func d(_ item: Any?) {
        if logLevel == .verbose || logLevel == .data {
            DispatchQueue.global(qos: logThread).async {
                print("\n[LOG]---\(self.appName)---\n\(item != nil ? item! : "nil")\n")
            }
        }
    }
    
    /// Log error
    open func e(_ item: Any?) {
        if logLevel == .verbose || logLevel == .error {
            DispatchQueue.global(qos: logThread).async {
                print("\n[LOG]---\(self.appName)---\n\(item != nil ? item! : "nil")\n")
            }
        }
    }
    
    /// Log info
    open func i(_ item: Any?) {
        if logLevel == .verbose || logLevel == .info {
            DispatchQueue.global(qos: logThread).async {
                print("\n[LOG]---\(self.appName)---\n\(item != nil ? item! : "nil")\n")
            }
        }
    }
    
    // MARK: Static methods
    public static func v(_ item: Any?) {
        BaseLog.shared.v(item)
    }
    
    public static func d(_ item: Any?) {
        BaseLog.shared.d(item)
    }
    
    public static func e(_ item: Any?) {
        BaseLog.shared.e(item)
    }
    
    public static func i(_ item: Any?) {
        BaseLog.shared.i(item)
    }
}
