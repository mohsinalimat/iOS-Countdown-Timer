//
//  ChangeLocationViewController.swift
//  Glastometer
//
//  Created by Joe on 26/11/2014.
//  Copyright (c) 2014 Joe. All rights reserved.
//

import Foundation
import UIKit
import MapKit

class ChangeLocationViewController : UIViewController, MKMapViewDelegate
{
    @IBOutlet weak var mapView: MKMapView!
    let longPressRec = UILongPressGestureRecognizer()
    
    override func viewDidLoad() {
        longPressRec.addTarget(self, action: #selector(ChangeLocationViewController.longPressedView))
        mapView.addGestureRecognizer(longPressRec)
        mapView.showsUserLocation = true
        addPinToMap()
    }
    
    
    func addPinToMap(){
    
        let location = CLLocationCoordinate2D(latitude: SavedSettings().locationLatitude.doubleValue,
                                              longitude: SavedSettings().locationLongitude.doubleValue)
        
        let annotation = MyAnnotation(coordinate: location, title: SavedSettings().eventName as String, subtitle: "")
        mapView.addAnnotation(annotation)

        setCentreOfMapToLocation(location)
    }
    
    
    func setCentreOfMapToLocation(location: CLLocationCoordinate2D){
        let span = MKCoordinateSpan(latitudeDelta: 0.02, longitudeDelta: 0.02)
        let region = MKCoordinateRegion(center: location, span: span)
        mapView.setRegion(region, animated: true)
    }
    
    
    func longPressedView(){
        //Remove all other pins
        mapView.removeAnnotations(mapView.annotations)
        
        let touchPoint:CGPoint = longPressRec.locationInView(mapView)
        let touchMapCoordinate:CLLocationCoordinate2D = mapView.convertPoint(touchPoint, toCoordinateFromView: mapView)
        let annotation = MyAnnotation(coordinate: touchMapCoordinate, title: SavedSettings().eventName as String, subtitle: "")
        mapView.addAnnotation(annotation)
       
        //Save new location to SavedSettings.
        SavedSettings().locationLatitude = NSString(format: "%.6f", touchMapCoordinate.latitude)
        SavedSettings().locationLongitude = NSString(format: "%.6f", touchMapCoordinate.longitude)
        NSLog("\(touchMapCoordinate.latitude.description), \(touchMapCoordinate.longitude.description)")
    }
    
    
    //Change the map view with the segmented control
    @IBAction func changeMapView(sender: AnyObject) {
        
        if (sender.selectedSegmentIndex == 0){
            mapView.mapType = MKMapType.Standard
        }
        else if (sender.selectedSegmentIndex == 1){
            mapView.mapType = MKMapType.Hybrid
        }
        else if (sender.selectedSegmentIndex == 2){
            mapView.mapType = .Satellite
        }
    }
    

/*
    - (void)viewDidLoad
    {
    [super viewDidLoad];
    
    [self.mapView setDelegate:self];
    
    // Do any additional setup after loading the view.
    self.settings = [SettingsClass sharedSingleton];
    
    //This adds the gesture recognizer to the mapView for a long press... ie to drop a pin on the map... see handleLongPress method below
    UILongPressGestureRecognizer *lpgr = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(handleLongPress:)];
    lpgr.minimumPressDuration = 1.5; //user needs to press for 1.5 seconds
    [self.mapView addGestureRecognizer:lpgr];
    }
*/
    
    /* This make a popup box apear.
    let tapAlert = UIAlertController(title: "Long Pressed", message: "You just long pressed the long press view", preferredStyle: UIAlertControllerStyle.Alert)
    tapAlert.addAction(UIAlertAction(title: "OK", style: .Destructive, handler: nil))
    self.presentViewController(tapAlert, animated: true, completion: nil)
    */
    
}