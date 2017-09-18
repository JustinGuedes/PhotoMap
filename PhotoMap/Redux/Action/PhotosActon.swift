//
//  PhotosActon.swift
//  PhotoMap
//
//  Created by Justin Guedes on 2017/04/22.
//  Copyright © 2017 Private. All rights reserved.
//

enum PhotosAction: Action {
    
    case selectedPlace(Place)
    case selectedPhotoAtIndex(Int)
    
    var type: String {
        switch self {
        case let .selectedPlace(place):
            return "Selected Place: \(place.name)"
        case let .selectedPhotoAtIndex(index):
            return "Selected Photo At Index: \(index)"
        }
    }
    
}
