//
//  CountdownCalculator.swift
//  Glastometer
//
//  Created by Joe on 07/10/2014.
//  Copyright (c) 2014 Joe. All rights reserved.
//

import Foundation

open class CountdownCalculator
{
    var str = "Hello, Countdown Calculator"
    
    var targetDateTime:String = "2015-12-25 09:00"
    var targetName = "Christmas 2015"
    
    //Constants
    let SECONDS_PER_HOUR = 3600
    let SECONDS_PER_MINUTE = 60
    let SECONDS_PER_DAY = 86400
    
    func Config(_ targetDate:String)
    {
        targetDateTime = targetDate
    }
    
    
    func DaysFromSeconds(_ remainingSeconds:Double) -> Int{
        return Int(remainingSeconds) / SECONDS_PER_DAY
    }
    
    
    func DateFromString(_ dateStr:String, format:String="yyyy-MM-dd HH:mm") -> Date{
        let dateFmt = DateFormatter()
        dateFmt.timeZone = TimeZone.current
        dateFmt.dateFormat = format
        return dateFmt.date(from: dateStr)!
    }
    
    
    func RemainingDaysForBadge() -> Int
    {
        let targetDate = DateFromString(targetDateTime)
        let days = (Calendar.current as NSCalendar).components(.day, from: Date(), to: targetDate, options: []).day
        return days! + 1
    }
    
    
    func RemainingSleeps() -> (sleeps: Int, sleepsStr: String)
    {
        let targetDate = DateFromString(targetDateTime)
        let days = (Calendar.current as NSCalendar).components(.day, from: Date(), to: targetDate, options: []).day! + 1
        
        var sleepsStr = "Sleep"                 //Set up the Sleeps(s) string for display
        if (days != 1) {
            sleepsStr += "s"
        }
        
        return (days, sleepsStr)
    }
    
    
    func RemainingSeconds() -> Double
    {
        let now = Date()
        let target = DateFromString(targetDateTime)
        let remaining = target.timeIntervalSince(now)
        return remaining
    }

    
    func RemainingDays() -> (days: Int, daysStr: String)
    {
        let remainingDays = DaysFromSeconds(RemainingSeconds())
        
        var daysStr = "Day"                     //Set up the Day(s) string for display
        if (remainingDays != 1) {
            daysStr += "s"
        }
        
        return (remainingDays, daysStr)
    }
    
    
    func RemainingDaysLabel() -> String
    {
        var daysStr = "Day"                     //Set up the Day(s) string for display
        if (RemainingDays().days != 1) {
            daysStr += "s"
        }
        return daysStr
    }
    
    
    func RemainingWeeks() -> (weeks: Int, days: Int)
    {
        let remainingWeeks = RemainingDays().days / 7
        let remainingDaysAfterWeeks = RemainingDays().days % 7
        
        return (remainingWeeks, remainingDaysAfterWeeks)
    }
    
    
    func RemainingDaysHoursMinutes() -> (days: Int, hours: Int, minutes: Int, daysStr: String, hoursStr: String, minutesStr: String)
    {
        let hours:Int = (Int(RemainingSeconds()) % SECONDS_PER_DAY) / SECONDS_PER_HOUR
        let minutes:Int = ((Int(RemainingSeconds()) % SECONDS_PER_DAY) % SECONDS_PER_HOUR) / 60
        
        var hoursStr = "Hour"                   //Set up the Hour(s) string for display
        if (hours != 1) {
            hoursStr += "s"
        }

        var minutesStr = "Minute"               //Set up the Minute(s) string for display
        if (minutes != 1) {
            minutesStr += "s"
        }
        
        return (RemainingDays().days, hours, minutes, RemainingDays().daysStr, hoursStr, minutesStr)
    }
    
    
    func RemainingWeeksLabels() -> (weeksLbl: String, daysLbl: String)
    {
        let weeksDaysRemaining = RemainingWeeks()
        
        var daysStr = "Day"                     //Set up the Day(s) string for display
        if (weeksDaysRemaining.days != 1) {
            daysStr += "s"
        }
        
        var weeksStr = "Week"                   //Set up the Week(s) string for display
        if (weeksDaysRemaining.weeks != 1) {
            weeksStr += "s"
        }

        return (weeksStr, daysStr)
    }
}
