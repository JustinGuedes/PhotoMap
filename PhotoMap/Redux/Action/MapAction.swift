//
//  MapAction.swift
//  PhotoMap
//
//  Created by Justin Guedes on 2017/04/20.
//  Copyright © 2017 Private. All rights reserved.
//

import MapKit

enum MapAction: Action {
    
    case requestedAuthorization(CLAuthorizationStatus)
    
    var type: String {
        switch self {
        case let .requestedAuthorization(status):
            return "Requested Authorization [\(status)]"
        }
    }
    
}
