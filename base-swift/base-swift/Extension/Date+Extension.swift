//
//  Date+Extension.swift
//  BaseSwift
//
//  Created by Macbook Pro 2017 on 7/14/20.
//  Copyright © 2020 Shantaram K. All rights reserved.
//

import Foundation
extension Date {
    var millisecondsSince1970:Int64 {
        return Int64((self.timeIntervalSince1970 * 1000.0).rounded())
    }

    init(milliseconds:Int64) {
        self = Date(timeIntervalSince1970: TimeInterval(milliseconds) / 1000)
    }
    
    var startOfDay: Date {
        return Calendar.current.startOfDay(for: self)
    }

    var endOfDay: Date {
        var components = DateComponents()
        components.day = 1
        components.second = -1
        return Calendar.current.date(byAdding: components, to: startOfDay)!
    }

    var startOfMonth: Date {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.year, .month], from: self)
        return  calendar.date(from: components)!
    }

    var endOfMonth: Date {
        var components = DateComponents()
        components.month = 1
        components.second = -1
        return Calendar(identifier: .gregorian).date(byAdding: components, to: startOfMonth)!
    }
    
    var startOfYear: Date {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.year], from: self)
        return  calendar.date(from: components)!
    }
    
    var endOfYear: Date {
        var components = DateComponents()
        components.year = 1
        components.second = -1
        return Calendar(identifier: .gregorian).date(byAdding: components, to: startOfYear)!
    }
    
    func isOnSelectedDate(_ _startTime: Date, _ _endTime: Date) -> Bool {
        let startday  = self.startOfDay.millisecondsSince1970
        let endday    = self.endOfDay.millisecondsSince1970
        let startTime   = _startTime.millisecondsSince1970
        let endTime     = _endTime.millisecondsSince1970
        return (startTime >= startday) && (endTime <= endday)
    }
}

extension Date {
    var withoutTime: Date {
        let dateComponents = Calendar.current.dateComponents([.day, .month, .year], from: self)
        return Calendar.current.date(from: dateComponents) ?? self
    }
    
    var isToday: Bool {
        let today = Date()
        return today.withoutTime.compare(self.withoutTime) == .orderedSame
    }
}
