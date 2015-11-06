//
//  MyAnnotation.swift
//  Glastometer
//
//  Created by Joe on 26/11/2014.
//  Copyright (c) 2014 Joe. All rights reserved.
//

import UIKit
import MapKit

class MyAnnotation : NSObject, MKAnnotation {
    
    var coordinate: CLLocationCoordinate2D = CLLocationCoordinate2DMake(0,0)
    var title: String?
    var subtitle: String?
    
    init(coordinate: CLLocationCoordinate2D, title: String, subtitle: String) {
        self.coordinate = coordinate
        self.title = title
        self.subtitle = subtitle
        
        //self.animatesDrop = true
        super.init()
    }
}
