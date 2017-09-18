//
//  MapStateReducerTests.swift
//  PhotoMap
//
//  Created by Justin Guedes on 2017/04/20.
//  Copyright © 2017 Private. All rights reserved.
//

import XCTest
import MapKit

class MapStateReducerTests: XCTestCase {
    
    var serviceUnderTest: MapStateReducer!
    
    override func setUp() {
        super.setUp()
        serviceUnderTest = MapStateReducer()
    }
    
    func testDefaultValuesForNewStateObject() {
        let result = MapState()
        
        XCTAssertFalse(result.hasAskedForAuthorization)
        XCTAssertFalse(result.canShowUsersLocation)
    }
    
    func testThatCanShowUserLocationWhenRequestedLocationPermission() {
        let result = serviceUnderTest.reduce(MapState(), .requestedAuthorization(.authorizedWhenInUse))
        
        XCTAssertTrue(result.hasAskedForAuthorization)
        XCTAssertTrue(result.canShowUsersLocation)
    }
    
    func testThatCanNotShowUserLocationWhenRequestedLocationPermissionAndNotCorrectStatus() {
        let result = serviceUnderTest.reduce(MapState(), .requestedAuthorization(.denied))
        
        XCTAssertTrue(result.hasAskedForAuthorization)
        XCTAssertFalse(result.canShowUsersLocation)
    }
    
}
