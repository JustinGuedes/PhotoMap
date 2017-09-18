//
//  GoogleAction.swift
//  PhotoMap
//
//  Created by Justin Guedes on 2017/04/21.
//  Copyright © 2017 Private. All rights reserved.
//

enum GoogleAction: Action {
    
    case getPlacesAroundCurrentLocation
    case reloadPlacesAroundCurrentLocation
    case retrievedPlaces([Place])
    
    case getPhotosForSelectedPlace
    case retrievedPhotos([Photo])
    
    case errorOccurred(String)
    
    var type: String {
        switch self {
        case .getPlacesAroundCurrentLocation:
            return "Get Places Around Current Location"
        case .reloadPlacesAroundCurrentLocation:
            return "Reload Places Around Current Location"
        case let .retrievedPlaces(places):
            return "Retrieved Places [\(places.count)]"
        case .getPhotosForSelectedPlace:
            return "Get Photos For Selected Places"
        case let .retrievedPhotos(photos):
            return "Retrieved Photos [\(photos.count)]"
        case let .errorOccurred(errorMessage):
            return "Error Occurred: \(errorMessage)"
        }
    }

}
