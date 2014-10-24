//
//  AppDelegate.swift
//  Glastometer
//
//  Created by Joe on 06/10/2014.
//  Copyright (c) 2014 Joe. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    let thisCountdown = CountdownCalculator()

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {

        UIApplication.sharedApplication().setMinimumBackgroundFetchInterval(UIApplicationBackgroundFetchIntervalMinimum)
        
        let types:UIUserNotificationType = UIUserNotificationType.Badge
        let mySettings:UIUserNotificationSettings = UIUserNotificationSettings(forTypes: types, categories: nil)
        UIApplication.sharedApplication().registerUserNotificationSettings(mySettings)
        
        return true
    }

    
    func application(application: UIApplication!, performFetchWithCompletionHandler completionHandler: ((UIBackgroundFetchResult) -> Void)!)
    {
        NSLog("Starting background fetch")
        setBadge(application)
        
        //This is just for testing (use above line) - comment to test commit.
        //testBackgroundFetch(application)
        
        completionHandler(UIBackgroundFetchResult.NewData)
        
        NSLog("Finished background fetch")
    }
    
    
    //--- Test function to set the icon badge to the current time in HHmm - used to test frequency of BackgroundFetchIntervalMinimum
    func testBackgroundFetch(application: UIApplication)
    {
        var now = NSDate()
        
        let formatter = NSDateFormatter()
        formatter.dateFormat = "HHmm"
        formatter.stringFromDate(now)
        var myTime:Int
        myTime = formatter.stringFromDate(now).toInt()!
        
        application.applicationIconBadgeNumber = myTime
    }
    
    
    func setBadge(application: UIApplication)
    {
        var defaults = NSUserDefaults(suiteName: "group.glastometer.com")!
        
        // Get the icon badge switch state from NSUserDefaults
        var showIconBadge = defaults.objectForKey("showIconBadge") as? Bool
        if (showIconBadge!)
        {
            var targetDate = defaults.objectForKey("targetDate") as? String!
            if (targetDate == nil) {
                targetDate = "2014-12-25 12:34"
            }
            
            thisCountdown.Config(targetDate!)
            
            application.applicationIconBadgeNumber = thisCountdown.RemainingDays().days
        }
    }
    
    
    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
        
        setBadge(application)
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

