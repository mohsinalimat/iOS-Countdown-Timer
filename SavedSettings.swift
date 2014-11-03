//
//  SavedSettings.swift
//  Glastometer
//
//  Created by Joe on 02/11/2014.
//  Copyright (c) 2014 Joe. All rights reserved.
//

import Foundation

public class SavedSettings
{
    var defaults: NSUserDefaults = NSUserDefaults(suiteName: "group.glastometer.com")!
    
    var targetDate: String {
        get {   NSLog("Saved Settings Class - get - targetDate")
                return (defaults.objectForKey("targetDate") as? String) ?? "2014-12-25 08:00" }
        set {   NSLog("Saved Settings Class - set - targetDate")
                defaults.setObject(newValue, forKey: "targetDate")
                defaults.synchronize() }
    }
    
    
    var sharingMessage: NSString {
        get {   NSLog("Saved Settings Class - get - sharingMessage")
                return (defaults.objectForKey("sharingMessage") as? String) ?? "to Glastonbury Festival 2015" }
        set {   NSLog("Saved Settings Class - set - sharingMessage")
                defaults.setObject(newValue, forKey: "sharingMessage")
                defaults.synchronize() }
    }
    
    
    var eventName: NSString {
        get {   NSLog("Saved Settings Class - get - eventName")
            return (defaults.objectForKey("eventName") as? String) ?? "Glastonbury" }
        set {   NSLog("Saved Settings Class - set - eventName")
            defaults.setObject(newValue, forKey: "eventName")
            defaults.synchronize() }
    }
    
    
    var showIconBadge: Bool {
        get {   NSLog("Saved Settings Class - get - showIconBadge")
                return (defaults.objectForKey("showIconBadge") as? Bool) ?? true }
        set {   NSLog("Saved Settings Class - set - showIconBadge")
                defaults.setObject(newValue, forKey: "showIconBadge")
                defaults.synchronize() }
    }
    


    
    
}