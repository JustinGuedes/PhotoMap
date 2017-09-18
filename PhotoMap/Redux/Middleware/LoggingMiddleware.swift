//
//  LoggingMiddleware.swift
//  PhotoMap
//
//  Created by Justin Guedes on 2017/04/23.
//  Copyright © 2017 Private. All rights reserved.
//

struct LoggingMiddleware {
    
    typealias Dispatch = (PhotoMapAction) -> Void
    
    static func execute(_ dispatchFunction: @escaping Dispatch, _ state: @escaping () -> PhotoMapState?) -> (_ nextDispatch: @escaping Dispatch) -> Dispatch {
        return { nextDispatch in
            return { action in
                print("Dispatching action: \(action.type)")
                nextDispatch(action)
            }
        }
    }
    
}
