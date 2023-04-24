//
//  TimeConvertUtils.swift
//  base-swift
//
//  Created by ThiemJason on 24/04/2023.
//  Copyright © 2023 BaseSwift. All rights reserved.
//

import Foundation
import AVKit

enum actionDate {
    case today
    case tomorrow
}

enum hourType {
    case hour
    case minute
    case second
}

func timeString(time: Int) -> String {
    let hour = time / 3600
    let minute = (time % 3600) / 60
    let second = (time % 3600) % 60

    // return formated string
    return String(format: "%02i:%02i:%02i", hour, minute, second)
}

func timeStringToMinute(time: Int) -> String {
    let minute = time / 60
    let second = time % 60

    // return formated string
    return String(format: "%02i:%02i", minute, second)
}

func getDateFromTimeStamp(timeStamp : Double) -> String {

    let date = NSDate(timeIntervalSince1970: timeStamp)

    let dayTimePeriodFormatter = DateFormatter()
    dayTimePeriodFormatter.dateFormat = "yyyy_MM_dd_HH_mm_ss"

    let dateString = dayTimePeriodFormatter.string(from: date as Date)
    return dateString
}

func getDateFromUnixTime(unixTime : Int64, format: String = "dd/MM/yyyy HH:mm:ss") -> String {
    
    let unixTimestamp = Double(unixTime)/1000
    
    let date = NSDate(timeIntervalSince1970: unixTimestamp)

    let dayTimePeriodFormatter = DateFormatter()
    dayTimePeriodFormatter.timeZone = TimeZone(identifier: Constant.Values.currentTimeZone)!
    dayTimePeriodFormatter.locale = NSLocale.current
    dayTimePeriodFormatter.dateFormat = format

    let dateString = dayTimePeriodFormatter.string(from: date as Date)
    return dateString
}

func getTimeAnđDateFromUnixTime(unixTime : Int64) -> String {
    
    let unixTimestamp = Double(unixTime)/1000
    
    let date = NSDate(timeIntervalSince1970: unixTimestamp)

    let dayTimePeriodFormatter = DateFormatter()
    dayTimePeriodFormatter.timeZone = TimeZone(identifier: Constant.Values.currentTimeZone)!
    dayTimePeriodFormatter.locale = NSLocale.current
    dayTimePeriodFormatter.dateFormat = "HH:mm:ss dd/MM/yyyy"

    let dateString = dayTimePeriodFormatter.string(from: date as Date)
    return dateString
}

func getOnlyDateFromUnixTime(unixTime : Int64) -> String {
    
    let unixTimestamp = Double(unixTime - 86400000)/1000
    
    let date = NSDate(timeIntervalSince1970: unixTimestamp)

    let dayTimePeriodFormatter = DateFormatter()
    dayTimePeriodFormatter.timeZone = TimeZone(identifier: Constant.Values.currentTimeZone)!
    dayTimePeriodFormatter.locale = NSLocale.current
    dayTimePeriodFormatter.dateFormat = "dd"

    let dateString = dayTimePeriodFormatter.string(from: date as Date)
    return dateString
}

func getDateOnlyFromTimeStamp(timeStamp : Double) -> String {
    let date = NSDate(timeIntervalSince1970: timeStamp)

    let dayTimePeriodFormatter = DateFormatter()
    dayTimePeriodFormatter.dateFormat = "dd/MM/yyyy"

    let dateString = dayTimePeriodFormatter.string(from: date as Date)
    return dateString
}

func getDateIntValueFromTimeStamp(timeStamp : Double) -> Int {
    
    
    let date = Date(timeIntervalSince1970: timeStamp)
    
    let calendar = Calendar.current

    let hour = calendar.component(.hour, from: date)
    let minutes = calendar.component(.minute, from: date)
    let seconds = calendar.component(.second, from: date)
    
    let intHour = hour * 3600
    
    let intMinute = minutes * 60
    
    let currenTimeToInt = seconds + intHour + intMinute
     
    return currenTimeToInt
}

func formatTime(timeStampString: String) -> Int {
    let string = String(format: "1970-01-02 %@", timeStampString)
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd HH:mm"
    print("Time String", timeStampString)
    var tempDate = Date()
    tempDate = dateFormatter.date(from: string) ?? dateFormatter.date(from: "00:00")!
    let time1 = tempDate.timeIntervalSince1970

    let timeInt = Int(time1)
    
    return timeInt
}

func milisecondsToDay(time: Int) -> Int{
    let seconds = time/1000
    let minutes = seconds/60
    let hours = minutes/60
    let days = hours/24
    return days
}

func getMediaDuration(url: URL!) -> Double{
    let asset : AVURLAsset = AVURLAsset(url: url) as AVURLAsset
    let duration : CMTime = asset.duration
    return CMTimeGetSeconds(duration)
}

func timeIntToString(time: Int) -> String{
    if time < 10 {
        return "0" + String(time)
    }else{
        return String(time)
    }
}

func getNowOrTomorrow(type: actionDate) -> String {
    var calendar = Calendar.current
    calendar.timeZone = TimeZone(identifier: Constant.Values.currentTimeZone)!
    let tomorrowCalendar = calendar.date(byAdding: .day, value: 1, to: Date()) ?? Date()
    
    let todayDate = calendar.component(.day, from: Date())
    let todayMonth = calendar.component(.month, from: Date())
    let todayYear = calendar.component(.year, from: Date())

    let tomorrowDate = calendar.component(.day, from: tomorrowCalendar)
    let tomorrowMonth = calendar.component(.month, from: tomorrowCalendar)
    let tomorrowYear = calendar.component(.year, from: tomorrowCalendar)
    
    if type == .today {
        let todayDateString = timeIntToString(time: todayDate)
        let todayMonthString = timeIntToString(time: todayMonth)
        
        let nowOrTomorrowString = dLocalized("KEY_TODAY")
                                + ": " + todayDateString
                                + "/"
                                + todayMonthString
                                + "/"
                                + "\(todayYear)"
        return nowOrTomorrowString
    }else{
        let tomorrowDateString = timeIntToString(time: tomorrowDate)
        let tomorrowMonthString = timeIntToString(time: tomorrowMonth)

        let nowOrTomorrowString = dLocalized("KEY_TOMORROW")
                                + ": " + tomorrowDateString
                                + "/"
                                + tomorrowMonthString
                                + "/"
                                + "\(tomorrowYear)"
        return nowOrTomorrowString
    }
}

func getAllTimezone(){
    let knownTimeZoneIdentifiers = TimeZone.knownTimeZoneIdentifiers
        for tz in TimeZone.knownTimeZoneIdentifiers {
            let timeZone = TimeZone(identifier: tz)
            if let abbreviation = timeZone?.abbreviation(), let seconds = timeZone?.secondsFromGMT() {
                print ("timeZone: \(tz) \nabbreviation: \(abbreviation)\nsecondsFromGMT: \(seconds)\n")
            }
        }
}


func timeWithPreZero(timeString: String) -> String {
//    let timeToInt = Int(timeString) ?? 0
    if timeString.count < 2 {
        let timeRevert = "0" + timeString
        return timeRevert
    }else{
        return timeString
    }
}

func getCurrentTimeStamp() -> String {
    return Date().timeIntervalSince1970.convertDoubleToString()
}

func getCurrentmilliseconds() -> String  {
    return (Date().timeIntervalSince1970*1000).convertDoubleToString()
}
