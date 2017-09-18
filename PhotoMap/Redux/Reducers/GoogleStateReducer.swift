//
//  GoogleStateReducer.swift
//  PhotoMap
//
//  Created by Justin Guedes on 2017/04/21.
//  Copyright © 2017 Private. All rights reserved.
//

struct GoogleStateReducer: Reducer {
    
    func reduce(_ previousState: GoogleState, _ action: GoogleAction) -> GoogleState {
        var newState = previousState
        
        switch action {
        case .getPlacesAroundCurrentLocation: fallthrough
        case .reloadPlacesAroundCurrentLocation:
            newState.errorMessage = .none
            newState.isLoadingData = true
            newState.places = []
        case let .retrievedPlaces(places):
            newState.isLoadingData = false
            newState.places = places
        case .getPhotosForSelectedPlace:
            newState.errorMessage = .none
            newState.isLoadingData = true
            newState.photos = []
        case let .retrievedPhotos(photos):
            newState.isLoadingData = false
            newState.photos = photos
        case let .errorOccurred(errorMessage):
            newState.isLoadingData = false
            newState.errorMessage = errorMessage
        }
        
        return newState
    }
    
}
