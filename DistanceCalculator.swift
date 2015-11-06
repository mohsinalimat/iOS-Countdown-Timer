//
//  DistanceCalculator.swift
//  Glastometer
//
//  Created by Joe on 30/11/2014.
//  Copyright (c) 2014 Joe. All rights reserved.
//

import Foundation
import CoreLocation

public class DistanceCalculator : NSObject, CLLocationManagerDelegate
{
    var targetLocation:CLLocation
    var currentLocation:CLLocation
    var remainingDistance:Double = 0.0
    var locationManager:CLLocationManager
    var locationServicesRunning:Bool = false

    
    override init(){

        targetLocation = CLLocation(latitude: SavedSettings().locationLatitude.doubleValue,
                                    longitude: SavedSettings().locationLongitude.doubleValue)
        locationManager = CLLocationManager()
        currentLocation = CLLocation()
        
        super.init()
        
        locationManager.distanceFilter = kCLDistanceFilterNone
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.delegate = self
        
        if CLLocationManager.authorizationStatus() == .NotDetermined {
            locationManager.requestWhenInUseAuthorization()
        }
        
        startGettingCurrentLocation()
    }
    
    
    public func getRemainingDistance() -> Double
    {
        targetLocation = CLLocation(latitude: SavedSettings().locationLatitude.doubleValue,
            longitude: SavedSettings().locationLongitude.doubleValue)
        NSLog("Target:  \(targetLocation.description) ")
        NSLog("Current: \(currentLocation.description)")
        remainingDistance = targetLocation.distanceFromLocation(currentLocation)
        return remainingDistance
    }
    
    
    public func locationManager(manager: CLLocationManager, didFailWithError error: NSError) {
        NSLog(error.description)
    }
    
    
    public func locationManager(manager: CLLocationManager, didUpdateToLocation newLocation: CLLocation, fromLocation oldLocation: CLLocation) {
        currentLocation = newLocation
    }
    
    
    public func stopGettingCurrentLocation()
    {
        locationManager.stopUpdatingLocation()
        locationServicesRunning = false
        NSLog("Stopped location services")
    }
    
    
    public func startGettingCurrentLocation()
    {
        if (!locationServicesRunning)
        {
            locationManager.startUpdatingLocation()
            locationServicesRunning = true
            NSLog("Started location services")
        }
    }
    
    public func locationServicesEnabled() -> Bool
    {
        if  (CLLocationManager.authorizationStatus() == .Denied)
        {
            return false
        }
        return true
    }
    
}
