//
//  SavedSettings.swift
//  Glastometer
//
//  Created by Joe on 02/11/2014.
//  Copyright (c) 2014 Joe. All rights reserved.
//

import Foundation
import MapKit

open class SavedSettings
{
    let TARGET_DATE:String      = "2017-06-21 08:00"
    let SHARING_MESSAGE:String  = "to Glastonbury Festival"
    let EVENT_NAME:String       = "Glastonbury"
    let SHOW_ICON_BADGE:Bool    = true
    let LOCATION_LAT:String     = "51.155543"
    let LOCATION_LONG:String    = "-2.586368"
    
    var defaults: UserDefaults = UserDefaults(suiteName: "group.glastometer.com")!
    
    
    func ResetAllSettings()
    {
        defaults.set(TARGET_DATE, forKey: "targetDate")
        defaults.set(SHARING_MESSAGE, forKey: "sharingMessage")
        defaults.set(EVENT_NAME, forKey: "eventName")
        defaults.set(SHOW_ICON_BADGE, forKey: "showIconBadge")
        defaults.set(LOCATION_LAT, forKey: "locationLatitude")
        defaults.set(LOCATION_LONG, forKey: "locationLongitude")
        defaults.synchronize()
    }
    
    var targetDate: String {
        get {   NSLog("Saved Settings Class - get - targetDate")
                return (defaults.object(forKey: "targetDate") as? String) ?? TARGET_DATE }
        set {   NSLog("Saved Settings Class - set - targetDate")
                defaults.set(newValue, forKey: "targetDate")
                defaults.synchronize() }
    }
    
    
    var sharingMessage: NSString {
        get {   NSLog("Saved Settings Class - get - sharingMessage")
                return (defaults.object(forKey: "sharingMessage") as? String as NSString?) ?? SHARING_MESSAGE as NSString }
        set {   NSLog("Saved Settings Class - set - sharingMessage")
                defaults.set(newValue, forKey: "sharingMessage")
                defaults.synchronize() }
    }
    
    
    var eventName: NSString {
        get {   NSLog("Saved Settings Class - get - eventName")
                return (defaults.object(forKey: "eventName") as? String as NSString?) ?? EVENT_NAME as NSString }
        set {   NSLog("Saved Settings Class - set - eventName")
                defaults.set(newValue, forKey: "eventName")
                defaults.synchronize() }
    }
    
    
    var showIconBadge: Bool {
        get {   NSLog("Saved Settings Class - get - showIconBadge")
                return (defaults.object(forKey: "showIconBadge") as? Bool) ?? SHOW_ICON_BADGE }
        set {   NSLog("Saved Settings Class - set - showIconBadge")
                defaults.set(newValue, forKey: "showIconBadge")
                defaults.synchronize() }
    }
    
    
    var locationLatitude: NSString {
        get {   NSLog("Saved Settings Class - get - locationLatitude")
            return (defaults.object(forKey: "locationLatitude") as? String as NSString?) ?? LOCATION_LAT as NSString }
        set {   NSLog("Saved Settings Class - set - locationLatitude")
            defaults.set(newValue, forKey: "locationLatitude")
            defaults.synchronize() }
    }
    
    var locationLongitude: NSString {
        get {   NSLog("Saved Settings Class - get - locationLongitude")
            return (defaults.object(forKey: "locationLongitude") as? String as NSString?) ?? LOCATION_LONG as NSString }
        set {   NSLog("Saved Settings Class - set - locationLongitude")
            defaults.set(newValue, forKey: "locationLongitude")
            defaults.synchronize() }
    }

}
