//
//  MKAnimal.swift
//  iMoose
//
//  Created by Brent Pendergraft on 4/22/15.
//  Copyright (c) 2015 Bpenderg. All rights reserved.
//

import MapKit

extension Animal : MKAnnotation {
    
    var coordinate: CLLocationCoordinate2D {
        return CLLocationCoordinate2D(latitude: latitude.doubleValue, longitude: longitude.doubleValue)
    }
    
    var title: String! { return species }
    
    var subtitle: String! {
        var nf = NSNumberFormatter()
        let weightAsString = nf.stringFromNumber(weight)
        
        return color + " - " + weightAsString! + "lbs"
     }
}
 