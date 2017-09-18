//
//  PhotoMapReducer.swift
//  PhotoMap
//
//  Created by Justin Guedes on 2017/04/19.
//  Copyright © 2017 Private. All rights reserved.
//

struct PhotoMapReducer: Reducer {
    
    let mapReducer = MapStateReducer()
    let googleReducer = GoogleStateReducer()
    let photosReducer = PhotosStateReducer()
    
    func reduce(_ previousState: PhotoMapState, _ action: PhotoMapAction) -> PhotoMapState {
        var newState = previousState
        
        switch action {
        case let .mapView(mapAction):
            newState.mapState = mapReducer.reduce(previousState.mapState, mapAction)
        case let .googleService(googleAction):
            newState.googleState = googleReducer.reduce(previousState.googleState, googleAction)
        case let .photosView(photosAction):
            newState.photosState = photosReducer.reduce(previousState.photosState, photosAction)
        }
        
        return newState
    }
    
}
