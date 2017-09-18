//
//  Reducer.swift
//  PhotoMap
//
//  Created by Justin Guedes on 2017/04/19.
//  Copyright © 2017 Private. All rights reserved.
//

protocol Reducer {
    
    associatedtype State
    associatedtype Action
    
    func reduce(_ previousState: State, _ action: Action) -> State
    
}
