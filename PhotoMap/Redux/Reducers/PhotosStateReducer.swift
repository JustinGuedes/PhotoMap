//
//  PhotosReducer.swift
//  PhotoMap
//
//  Created by Justin Guedes on 2017/04/22.
//  Copyright © 2017 Private. All rights reserved.
//

struct PhotosStateReducer: Reducer {
    
    func reduce(_ previousState: PhotosState, _ action: PhotosAction) -> PhotosState {
        var newState = previousState
        
        switch action {
        case let .selectedPlace(place):
            newState.selectedPlace = place
        case let .selectedPhotoAtIndex(selectedPhoto):
            newState.selectedPhoto = selectedPhoto
        }
        
        return newState
    }
    
}
