//
//  Place.swift
//  PhotoMap
//
//  Created by Justin Guedes on 2017/04/21.
//  Copyright © 2017 Private. All rights reserved.
//

import MapKit

protocol Place {
    
    var id: String { get }
    var name: String { get }
    var coordinate: CLLocationCoordinate2D { get }
    var address: String? { get }
    
}
