//
//  DistanceCalculator.swift
//  Glastometer
//
//  Created by Joe on 30/11/2014.
//  Copyright (c) 2014 Joe. All rights reserved.
//

import Foundation
import CoreLocation

open class DistanceCalculator : NSObject, CLLocationManagerDelegate
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
        
        if CLLocationManager.authorizationStatus() == .notDetermined {
            locationManager.requestWhenInUseAuthorization()
        }
        
        startGettingCurrentLocation()
    }
    
    
    open func getRemainingDistance() -> Double
    {
        targetLocation = CLLocation(latitude: SavedSettings().locationLatitude.doubleValue,
            longitude: SavedSettings().locationLongitude.doubleValue)
        NSLog("Target:  \(targetLocation.description) ")
        NSLog("Current: \(currentLocation.description)")
        remainingDistance = targetLocation.distance(from: currentLocation)
        return remainingDistance
    }
    
    
    open func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        //NSLog(error)
    }
    
    
    open func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        currentLocation = locations[0]     // .newLocation
        //newLocation
    }
    
    
    open func stopGettingCurrentLocation()
    {
        locationManager.stopUpdatingLocation()
        locationServicesRunning = false
        NSLog("Stopped location services")
    }
    
    
    open func startGettingCurrentLocation()
    {
        if (!locationServicesRunning)
        {
            locationManager.startUpdatingLocation()
            locationServicesRunning = true
            NSLog("Started location services")
        }
    }
    
    open func locationServicesEnabled() -> Bool
    {
        if  (CLLocationManager.authorizationStatus() == .denied)
        {
            return false
        }
        return true
    }
    
}
