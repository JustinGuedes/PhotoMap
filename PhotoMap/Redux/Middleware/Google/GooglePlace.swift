//
//  GooglePlace.swift
//  PhotoMap
//
//  Created by Justin Guedes on 2017/04/21.
//  Copyright © 2017 Private. All rights reserved.
//

import MapKit

struct GooglePlace: Place {
    
    let id: String
    let name: String
    let coordinate: CLLocationCoordinate2D
    let address: String?
    
}
