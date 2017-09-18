//
//  PlaceAnnotation.swift
//  PhotoMap
//
//  Created by Justin Guedes on 2017/04/23.
//  Copyright © 2017 Private. All rights reserved.
//

import MapKit

class PlaceAnnotation: NSObject, MKAnnotation {
    
    let place: Place
    
    var title: String? {
        return place.name
    }
    
    var subtitle: String? {
        return place.address
    }
    
    var coordinate: CLLocationCoordinate2D {
        return place.coordinate
    }
    
    init(place: Place) {
        self.place = place
        super.init()
    }
    
}
