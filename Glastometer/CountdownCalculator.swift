//
//  CountdownCalculator.swift
//  Glastometer
//
//  Created by Joe on 07/10/2014.
//  Copyright (c) 2014 Joe. All rights reserved.
//

import Foundation

public class CountdownCalculator
{
    var str = "Hello, Countdown Calculator"
    
    var targetDateTime:String = "2014-12-25 09:00"
    var targetName = "Christmas 2015"
    
    //Constants
    let SECONDS_PER_HOUR = 3600
    let SECONDS_PER_MINUTE = 60
    let SECONDS_PER_DAY = 86400
    let METERS_PER_MILE = 1609.344
    
    func Config(targetDate:String)
    {
        targetDateTime = targetDate
    }
    
    
    func DaysFromSeconds(remainingSeconds:Double) -> Int{
        return Int(remainingSeconds) / SECONDS_PER_DAY
    }
    
    
    func DateFromString(dateStr:String, format:String="yyyy-MM-dd HH:mm") -> NSDate{
        var dateFmt = NSDateFormatter()
        dateFmt.timeZone = NSTimeZone.defaultTimeZone()
        dateFmt.dateFormat = format
        return dateFmt.dateFromString(dateStr)!
    }
    
    
    func RemainingDays() -> Int
    {
        var now = NSDate()
        var target = DateFromString(targetDateTime)
        var remaining = target.timeIntervalSinceDate(now)
        var remainingDays = DaysFromSeconds(remaining)
        return remainingDays
    }
    
    
    func RemainingDaysLabel() -> String
    {
        var daysStr = "Day"                     //Set up the Day(s) string for display
        if (RemainingDays() != 1) {
            daysStr += "s"
        }
        return daysStr
    }
    
    
    func RemainingWeeks() -> (weeks: Int, days: Int)
    {
        var remainingWeeks = RemainingDays() / 7
        var remainingDaysAfterWeeks = RemainingDays() % 7
        
        return (remainingWeeks, remainingDaysAfterWeeks)
    }
    
    
    func RemainingWeeksLabels() -> (weeksLbl: String, daysLbl: String)
    {
        var weeksDaysRemaining = RemainingWeeks()
        
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