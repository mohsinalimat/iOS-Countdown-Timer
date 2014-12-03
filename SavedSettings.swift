//
//  SavedSettings.swift
//  Glastometer
//
//  Created by Joe on 02/11/2014.
//  Copyright (c) 2014 Joe. All rights reserved.
//

import Foundation
import MapKit

public class SavedSettings
{
    let TARGET_DATE:String      = "2015-06-24 08:00"
    let SHARING_MESSAGE:String  = "to Glastonbury Festival"
    let EVENT_NAME:String       = "Glastonbury"
    let SHOW_ICON_BADGE:Bool    = true
    let LOCATION_LAT:String     = "51.155543"
    let LOCATION_LONG:String    = "-2.586368"
    
    var defaults: NSUserDefaults = NSUserDefaults(suiteName: "group.glastometer.com")!
    
    
    func ResetAllSettings()
    {
        defaults.setObject(TARGET_DATE, forKey: "targetDate")
        defaults.setObject(SHARING_MESSAGE, forKey: "sharingMessage")
        defaults.setObject(EVENT_NAME, forKey: "eventName")
        defaults.setObject(SHOW_ICON_BADGE, forKey: "showIconBadge")
        defaults.setObject(LOCATION_LAT, forKey: "locationLatitude")
        defaults.setObject(LOCATION_LONG, forKey: "locationLongitude")
        defaults.synchronize()
    }
    
    var targetDate: String {
        get {   NSLog("Saved Settings Class - get - targetDate")
                return (defaults.objectForKey("targetDate") as? String) ?? TARGET_DATE }
        set {   NSLog("Saved Settings Class - set - targetDate")
                defaults.setObject(newValue, forKey: "targetDate")
                defaults.synchronize() }
    }
    
    
    var sharingMessage: NSString {
        get {   NSLog("Saved Settings Class - get - sharingMessage")
                return (defaults.objectForKey("sharingMessage") as? String) ?? SHARING_MESSAGE }
        set {   NSLog("Saved Settings Class - set - sharingMessage")
                defaults.setObject(newValue, forKey: "sharingMessage")
                defaults.synchronize() }
    }
    
    
    var eventName: NSString {
        get {   NSLog("Saved Settings Class - get - eventName")
                return (defaults.objectForKey("eventName") as? String) ?? EVENT_NAME }
        set {   NSLog("Saved Settings Class - set - eventName")
                defaults.setObject(newValue, forKey: "eventName")
                defaults.synchronize() }
    }
    
    
    var showIconBadge: Bool {
        get {   NSLog("Saved Settings Class - get - showIconBadge")
                return (defaults.objectForKey("showIconBadge") as? Bool) ?? SHOW_ICON_BADGE }
        set {   NSLog("Saved Settings Class - set - showIconBadge")
                defaults.setObject(newValue, forKey: "showIconBadge")
                defaults.synchronize() }
    }
    
    
    var locationLatitude: NSString {
        get {   NSLog("Saved Settings Class - get - locationLatitude")
            return (defaults.objectForKey("locationLatitude") as? String) ?? LOCATION_LAT }
        set {   NSLog("Saved Settings Class - set - locationLatitude")
            defaults.setObject(newValue, forKey: "locationLatitude")
            defaults.synchronize() }
    }
    
    var locationLongitude: NSString {
        get {   NSLog("Saved Settings Class - get - locationLongitude")
            return (defaults.objectForKey("locationLongitude") as? String) ?? LOCATION_LONG }
        set {   NSLog("Saved Settings Class - set - locationLongitude")
            defaults.setObject(newValue, forKey: "locationLongitude")
            defaults.synchronize() }
    }

}