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
        longPressRec.addTarget(self, action: "longPressedView")
        mapView.addGestureRecognizer(longPressRec)
        
        addPinToMap()
    }
    
    
    func addPinToMap(){
        let location = CLLocationCoordinate2D(latitude: 51.155543, longitude: -2.586368)
        let annotation = MyAnnotation(coordinate: location, title: SavedSettings().eventName, subtitle: "")
        mapView.addAnnotation(annotation)

        setCentreOfMapToLocation(location)
    }
    
    
    func setCentreOfMapToLocation(location: CLLocationCoordinate2D){
        let span = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
        let region = MKCoordinateRegion(center: location, span: span)
        mapView.setRegion(region, animated: true)
        
    }
    
    
    func longPressedView(){
        //Put the code in here to drop a new pin when long pressed complete.
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