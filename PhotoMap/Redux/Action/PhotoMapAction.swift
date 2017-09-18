//
//  PhotoMapAction.swift
//  PhotoMap
//
//  Created by Justin Guedes on 2017/04/19.
//  Copyright © 2017 Private. All rights reserved.
//

enum PhotoMapAction: Action {
    
    case mapView(MapAction)
    case googleService(GoogleAction)
    case photosView(PhotosAction)
    
    var type: String {
        switch self {
        case let .mapView(mapAction):
            return "Map View: \(mapAction.type)"
        case let .googleService(googleAction):
            return "Google Service: \(googleAction.type)"
        case let .photosView(photosAction):
            return "Photos View: \(photosAction.type)"
        }
    }
    
}
