//
//  MapStateReducer.swift
//  PhotoMap
//
//  Created by Justin Guedes on 2017/04/20.
//  Copyright © 2017 Private. All rights reserved.
//

import MapKit
import GooglePlaces

struct MapStateReducer: Reducer {
    
    func reduce(_ previousState: MapState, _ action: MapAction) -> MapState {
        var newState = previousState
        
        switch action {
        case let .requestedAuthorization(status):
            newState.hasAskedForAuthorization = true
            newState.canShowUsersLocation = status == .authorizedWhenInUse
        }
        
        return newState
    }
    
}
