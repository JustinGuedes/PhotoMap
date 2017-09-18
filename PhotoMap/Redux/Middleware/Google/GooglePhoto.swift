//
//  GooglePhoto.swift
//  PhotoMap
//
//  Created by Justin Guedes on 2017/04/21.
//  Copyright © 2017 Private. All rights reserved.
//

import GooglePlaces

class GooglePhoto: Photo {
    
    let id: String
    var title: String {
        return metadata.attributions?.string ?? metadata.description
    }
    
    private let metadata: GMSPlacePhotoMetadata
    
    init(id: String, metadata: GMSPlacePhotoMetadata) {
        self.id = id
        self.metadata = metadata
    }
    
    func loadImage(_ callback: @escaping (UIImage?) -> Void) {
        GMSPlacesClient.shared().loadPlacePhoto(metadata) { (image, _) in
            callback(image)
        }
    }
    
}
