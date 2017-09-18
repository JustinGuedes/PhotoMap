//
//  Middleware.swift
//  PhotoMap
//
//  Created by Justin Guedes on 2017/04/20.
//  Copyright © 2017 Private. All rights reserved.
//

//protocol Middleware {
//    
//    associatedtype State
//    associatedtype Action
//    
//    typealias Dispatch = (Action) -> Void
//    
//    func execute(_ dispatchFunction: @escaping Dispatch, _ state: @escaping () -> State?) -> (_ nextDispatch: @escaping Dispatch) -> Dispatch
//    
//}

typealias Dispatch<ActionType> = (ActionType) -> Void
typealias Middleware<ActionType, StateType> = (@escaping Dispatch<ActionType>, @escaping () -> StateType?) -> (@escaping Dispatch<ActionType>) -> Dispatch<ActionType>
