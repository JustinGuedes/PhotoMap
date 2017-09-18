//
//  ModelStubs.swift
//  PhotoMap
//
//  Created by Justin Guedes on 2017/04/21.
//  Copyright © 2017 Private. All rights reserved.
//

import MapKit

struct PlaceStub: Place {
    
    let id: String
    let name: String
    let coordinate: CLLocationCoordinate2D
    let address: String?
    
    init(_ id: String) {
        self.id = id
        name = id
        coordinate = CLLocationCoordinate2D()
        address = .none
    }
    
}

struct PhotoStub: Photo {
    
    let id: String
    let title: String
    
    func loadImage(_ callback: @escaping (UIImage?) -> Void) {
        
    }
    
    init(_ id: String) {
        self.id = id
        title = id
    }
    
}
