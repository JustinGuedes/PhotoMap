//
//  Subscriber.swift
//  PhotoMap
//
//  Created by Justin Guedes on 2017/04/19.
//  Copyright © 2017 Private. All rights reserved.
//

protocol Subscriber: AnySubscriber {
    
    associatedtype State
    
    func newState(_ state: State)
    
}

protocol AnySubscriber: class {
    
    func _newState(_ state: Any)
    
}

extension Subscriber {
    
    func _newState(_ state: Any) {
        guard let state = state as? State else {
            fatalError("State is of incorrect type")
        }
        
        newState(state)
    }
    
}
