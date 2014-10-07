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
    
    var targetDateTime = "2014-12-25 08:00"
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
        var now = NSDate.date()
        var target = DateFromString(targetDateTime)
        var remaining = target.timeIntervalSinceDate(now)
        var remainingDays = DaysFromSeconds(remaining)
        var Output1str = "\(remainingDays) Days to \(targetName)"
        
        var remainingWeeks = remainingDays / 7
        var remainingDaysAfterWeeks = remainingDays % 7
        
        var daysStr = "Day"                     //Set up the Day(s) string for display
        if (remainingDaysAfterWeeks != 1) {
            daysStr += "s"
        }
        
        var weeksStr = "Week"                   //Set up the Week(s) string for display
        if (remainingWeeks != 1) {
            weeksStr += "s"
        }
        
        var Output2Str : String
        if (remainingDaysAfterWeeks > 0)
        {
            if (remainingWeeks > 0)
            {
                Output2Str = "\(remainingWeeks) \(weeksStr), \(remainingDaysAfterWeeks) \(daysStr) to \(targetName)"
            }
            else
            {
                Output2Str = "\(remainingDaysAfterWeeks) \(daysStr) to \(targetName)"
            }
        }
        else
        {
            Output2Str = "\(remainingWeeks) \(weeksStr) to \(targetName)"
        }
        
        str = Output1str
        str = Output2Str

        return remainingDays
    }
    
    
    
    
    
}