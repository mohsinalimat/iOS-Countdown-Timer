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

open class IconBadge
{
    let thisCountdown = CountdownCalculator()
    var defaults: UserDefaults = UserDefaults(suiteName: "group.glastometer.com")!
    let MAXIMUM_NOTIFICATIONS = 365
    
    func setBadge()
    {
        //create an oject of UIApplication, must remember to 'import UIKit' as we're not in a ViewController.
        let application: UIApplication = UIApplication.shared
        
        // Get the icon badge switch state from NSUserDefaults
        let showIconBadge = SavedSettings().showIconBadge //defaults.objectForKey("showIconBadge") as? Bool
        if (showIconBadge)
        {
            // Get the target date from NSUserDefaults
            let targetDate = SavedSettings().targetDate //defaults.objectForKey("targetDate") as? String!
            thisCountdown.Config(targetDate)
            
            application.cancelAllLocalNotifications()
            application.scheduledLocalNotifications = localNotificationsStartingTomorrow()
            
            // Set the icon badge
            //application.applicationIconBadgeNumber = thisCountdown.RemainingDays().days
            application.applicationIconBadgeNumber = thisCountdown.RemainingDaysForBadge()
        }
        else
        {
            //Cancel all local notifications and set icon badge to 0 (hidden)
            application.cancelAllLocalNotifications()
            application.applicationIconBadgeNumber = 0 //Hide the badge if this option is turned off.
        }
    }
    
    
    func localNotificationsStartingTomorrow() -> [UILocalNotification]
    {
        var localNotifications: [UILocalNotification] = []
    
        //var daysRemaining: Int = thisCountdown.RemainingDays().days
        let daysRemaining: Int = thisCountdown.RemainingDaysForBadge()
        let date: Date = Date()
        
        for i in 1..<MAXIMUM_NOTIFICATIONS {
        //for var i = 1; i < MAXIMUM_NOTIFICATIONS; i += 1 {
            let notification: UILocalNotification = UILocalNotification()
            
            //Set the badge number for this notification
            notification.applicationIconBadgeNumber = daysRemaining - i
            
            //Create a firedate of midnight for this notification
            let components = DateComponents()
            (components as NSDateComponents).setValue(i, forComponent: NSCalendar.Unit.day);
            var notificationFireDate = (Calendar.current as NSCalendar).date(byAdding: components, to: date, options: NSCalendar.Options(rawValue: 0))
            notificationFireDate = (Calendar.current as NSCalendar).date(bySettingHour: 0, minute: 0, second: 0, of: notificationFireDate!, options: NSCalendar.Options())
            
            NSLog("\(notificationFireDate) \(daysRemaining - i)")
            
            //Set the fire date
            notification.fireDate = notificationFireDate
            
            //Add this notification to the array of notification to be returned from this function
            localNotifications.append(notification)
            
            //Stop adding notifications when the days remaining count reaches 0
            if (daysRemaining - i == 0)
            {
                //i = MAXIMUM_NOTIFICATIONS
                break
            }
        }
        
        return localNotifications
    }
    

    //--- Test function to set the icon badge to the current time in HHmm - used to test frequency of BackgroundFetchIntervalMinimum
    func testBackgroundFetch()
    {
        let now = Date()
        
        let formatter = DateFormatter()
        formatter.dateFormat = "HHmm"
        formatter.string(from: now)
        var myTime:Int
        myTime = Int(formatter.string(from: now))!
        
        let application: UIApplication = UIApplication.shared
        application.applicationIconBadgeNumber = myTime
    }
}


/*
//Notification called every 3 seconds
var notification: UILocalNotification = UILocalNotification()
notification.applicationIconBadgeNumber = i
notification.fireDate = NSDate(timeIntervalSinceNow: (NSTimeInterval)(1 + (3 * i)))
*/

