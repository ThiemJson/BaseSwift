//
//  Int64+Extension.swift
//  BaseSwift
//
//  Created by Macbook Pro 2017 on 7/14/20.
//  Copyright © 2020 Shantaram K. All rights reserved.
//

import Foundation
import Foundation
import UIKit
extension Int64 {
    func getDateStringFromUTC() -> String {
        let date = Date(timeIntervalSince1970: TimeInterval(self))

        let dateFormatter = DateFormatter()
//        dateFormatter.locale = Locale(identifier: "vi")
        dateFormatter.dateStyle = .medium
        
        dateFormatter.dateFormat = "dd/MM/yyyy"
        
        return dateFormatter.string(from: date)
    }
    
    func getTimeWithFormat(formart: String) -> String {
        let date = Date(timeIntervalSince1970: TimeInterval(self/1000))

        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "vi")
        dateFormatter.dateStyle = .medium
        dateFormatter.dateFormat = formart

        return dateFormatter.string(from: date)
    }
    
    func getCoordinatesOfTime() -> Double {
        let date = Date(timeIntervalSince1970: TimeInterval(self/1000))
        let oneHours:Int64 = 3600000
        let coorTime = self - date.startOfDay.millisecondsSince1970
        return (Double(coorTime/oneHours))
    }
    
    func getCoordinatesOfDate() -> Double {
        let date = Date(timeIntervalSince1970: TimeInterval(self/1000))
        let oneDate:Int64 = 86400000
        let coorTime = self - date.startOfMonth.millisecondsSince1970
        return (Double(Int(coorTime/oneDate))+1)
    }
    
    func getCoordinatesOfMonth() -> Double {
        let date = Date(timeIntervalSince1970: TimeInterval(self/1000))
//        let date = Date(timeIntervalSince1970: TimeInterval(self))
        
//        let oneMonth:Int64 = 86400000*29
//        let coorTime = self - date.startOfYear.millisecondsSince1970
        
        let formatter = DateFormatter()
        formatter.dateFormat = "MM"
        let month = formatter.string(from: date)
        return Double(month) ?? 0
//        return (Double(Int(coorTime/oneMonth))+1)
    }
}
