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
        //create an oject of UIApplication, must remember to 'import UIKit' as we're not in a ViewController.
        var application: UIApplication = UIApplication.sharedApplication()
        
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
            
            application.scheduledLocalNotifications = localNotificationsStartingTomorrow()
            
            // Set the icon badge
            application.applicationIconBadgeNumber = thisCountdown.RemainingDays().days
        }
        else
        {
            application.applicationIconBadgeNumber = 0 //Hide the badge if this option is turned off.
        }
    }
    
    
    
    func localNotificationsStartingTomorrow() -> [UILocalNotification]
    {
        var localNotifications: [UILocalNotification] = []
    
        for var i = 0; i < 365; i++
        {
            var notification: UILocalNotification = UILocalNotification()
            notification.applicationIconBadgeNumber = i
            notification.fireDate = NSDate(timeIntervalSinceNow: (NSTimeInterval)(1 + (3 * i)))
            UIApplication.sharedApplication().scheduleLocalNotification(notification)
            
            localNotifications.append(notification)
        }
        
        return localNotifications
    }
    
    /*
    
    
    -(NSArray *) localNotificationsStartingTomorrow{
    
    //Create an array of 64 notifications (64 is the maximum allowed per application)
    NSMutableArray *localNotifications = [[NSMutableArray alloc] initWithCapacity:64];
    
    for (NSUInteger i = 0; i < 64; i++){
    //Create a new local notification
    UILocalNotification *notification = [[UILocalNotification alloc] init];
    notification.hasAction = NO;
    
    //Create today's midnight date
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *todaysDateComponents = [calendar components:(NSEraCalendarUnit | NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit) fromDate:[NSDate date]];
    NSDate *todaysMidnight = [calendar dateFromComponents:todaysDateComponents];
    
    //Create the fire date
    NSDateComponents *addedDaysComponents = [[NSDateComponents alloc] init];
    addedDaysComponents.day = i;
    NSDate *fireDate = [calendar dateByAddingComponents:addedDaysComponents toDate:todaysMidnight options:0];
    
    //Set the fire date and time zone
    notification.fireDate = fireDate;
    notification.timeZone = [NSTimeZone systemTimeZone];
    
    //Set the badge number
    notification.applicationIconBadgeNumber = [self remainingDays] - (i + self.fudgeFactor);
    //NSLog(@"Notification: %@, Days %lu", fireDate, [self remainingDays] - (i + self.fudgeFactor));
    
    //Add the notification to the array
    [localNotifications addObject:notification];
    }
    
    return [localNotifications copy];
    }

    
    */
    
    
    
    
    
    
    
    
    
    
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