//
//  SavedSettings.swift
//  Glastometer
//
//  Created by Joe on 02/11/2014.
//  Copyright (c) 2014 Joe. All rights reserved.
//

import Foundation

class SavedSettings
{
    var defaults = NSUserDefaults.standardUserDefaults()
    
    var targetDate: String {
        get {   NSLog("Saved Settings Class used!")
                return (defaults.objectForKey("targetDate") as? String) ?? "2014-12-25 08:00"}
        set {   defaults.setObject(newValue, forKey: "targetDate")
                defaults.synchronize() }
    }
    
    
    
}