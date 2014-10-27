//
//  IconBadge.swift
//  Glastometer
//
//  This class handles everything to do with setting the apps icon badge - including local notification to
//  update the badge when the app is not running.
//
//  Created by Joe on 27/10/2014.
//  Copyright (c) 2014 Joe. All rights reserved.
//

import Foundation
import UIKit

public class IconBadge
{
    let thisCountdown = CountdownCalculator()
    var defaults: NSUserDefaults = NSUserDefaults(suiteName: "group.glastometer.com")!
    
    
    func setBadge()
    {
        // Get the icon badge switch state from NSUserDefaults
        var showIconBadge = defaults.objectForKey("showIconBadge") as? Bool
        if (showIconBadge!)
        {
            // Get the target date from NSUserDefaults
            var targetDate = defaults.objectForKey("targetDate") as? String!
            if (targetDate == nil) {
                targetDate = "2014-12-25 12:34"
            }
            thisCountdown.Config(targetDate!)
            
            // Set the icon badge
            //create an oject of UIApplication, must remember to 'import UIKit' as we're not in a ViewController.
            var application: UIApplication = UIApplication.sharedApplication()
            application.applicationIconBadgeNumber = thisCountdown.RemainingDays().days
        }
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    //--- Test function to set the icon badge to the current time in HHmm - used to test frequency of BackgroundFetchIntervalMinimum
    func testBackgroundFetch()
    {
        var now = NSDate()
        
        let formatter = NSDateFormatter()
        formatter.dateFormat = "HHmm"
        formatter.stringFromDate(now)
        var myTime:Int
        myTime = formatter.stringFromDate(now).toInt()!
        
        var application: UIApplication = UIApplication.sharedApplication()
        application.applicationIconBadgeNumber = myTime
    }
    

    
    
}