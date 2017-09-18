//
//  Store.swift
//  PhotoMap
//
//  Created by Justin Guedes on 2017/04/19.
//  Copyright © 2017 Private. All rights reserved.
//

class Store<StateType, ReducerType: Reducer, ActionType: Action> where ReducerType.State == StateType, ReducerType.Action == ActionType {
    
    typealias Dispatch = (ActionType) -> Void
    
    private let reducer: ReducerType
    private var subscribers: [AnySubscriber]
    private (set) var state: StateType {
        didSet {
            subscribers.forEach(updateSubscriber)
        }
    }
    private var dispatchFunction: Dispatch!
    
    init(_ reducer: ReducerType, _ state: StateType, _ middlewares: [Middleware<ActionType, StateType>]) {
        self.reducer = reducer
        self.subscribers = []
        self.state = state
        let reversedMiddlewares = middlewares.reversed()
        let initialDispatch: Dispatch = self._dispatch
        self.dispatchFunction = reversedMiddlewares.reduce(initialDispatch) { dispatch, middleware in
            let dispatchFunction: (ActionType) -> Void = { [weak self] in self?.dispatch($0) }
            let state = { [weak self] in self?.state }
            return middleware(dispatchFunction, state)(dispatch)
        }
    }
    
    init(_ reducer: ReducerType, _ state: StateType) {
        self.reducer = reducer
        self.subscribers = []
        self.state = state
        self.dispatchFunction = self._dispatch
    }
    
    func subscribe<SubscriberType: Subscriber>(_ subscriber: SubscriberType) where SubscriberType.State == StateType {
        subscribers.append(subscriber)
        updateSubscriber(subscriber)
    }
    
    func unsubscribe<SubscriberType: Subscriber>(_ subscriber: SubscriberType) where SubscriberType.State == StateType {
        guard let indexOfSubscriber = subscribers.index(where: { $0 === subscriber }) else {
            return
        }
        
        subscribers.remove(at: indexOfSubscriber)
    }
    
    func dispatch(_ action: ActionType) {
        dispatchFunction(action)
    }
    
    private func _dispatch(_ action: ActionType) {
        state = reducer.reduce(state, action)
    }
    
    private func updateSubscriber(_ subscriber: AnySubscriber) {
        subscriber._newState(state)
    }
    
}
