//
//  GoogleService.swift
//  PhotoMap
//
//  Created by Justin Guedes on 2017/04/20.
//  Copyright © 2017 Private. All rights reserved.
//

import GooglePlaces

struct GoogleService {
    
    typealias Dispatch = (PhotoMapAction) -> Void
    
    static func execute(_ dispatchFunction: @escaping Dispatch, _ state: @escaping () -> PhotoMapState?) -> (_ nextDispatch: @escaping Dispatch) -> Dispatch {
        return { nextDispatch in
            return { action in
                
                nextDispatch(action)
                switch action {
                case .googleService(.getPlacesAroundCurrentLocation): fallthrough
                case .googleService(.reloadPlacesAroundCurrentLocation): self.loadCurrentPlace(dispatchFunction)
                case .googleService(.getPhotosForSelectedPlace): self.loadPhotos(forPlace: state()?.photosState.selectedPlace, dispatchFunction)
                default:break
                }
                
            }
        }
    }
    
    fileprivate static func loadCurrentPlace(_ dispatch: @escaping Dispatch) {
        GMSPlacesClient.shared().currentPlace { (likelihoodList, error) in
            guard let places = likelihoodList?.likelihoods else {
                return dispatch(
                    .googleService(
                        .errorOccurred("Unable to load places around location")
                    )
                )
            }
            
            let googlePlaces: [Place] = places.flatMap { GooglePlace(id: $0.place.placeID, name: $0.place.name, coordinate: $0.place.coordinate, address: $0.place.formattedAddress) }
            dispatch(
                .googleService(
                    .retrievedPlaces(googlePlaces)
                )
            )
        }
    }
    
    fileprivate static func loadPhotos(forPlace place: Place?, _ dispatch: @escaping Dispatch) {
        guard let placeID = place?.id else { fatalError("Should never happen") }
        GMSPlacesClient.shared().lookUpPhotos(forPlaceID: placeID) { (placePhotosList, _) in
            guard let results = placePhotosList?.results else {
                return dispatch(
                    .googleService(
                        .errorOccurred("Unable to load photos")
                    )
                )
            }
            
            let googlePhotos = results.enumerated().map { GooglePhoto(id: "\($0.offset)", metadata: $0.element) }
            dispatch(
                .googleService(
                    .retrievedPhotos(googlePhotos)
                )
            )
        }
    }
    
}
