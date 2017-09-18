//
//  GoogleStateReducerTests.swift
//  PhotoMap
//
//  Created by Justin Guedes on 2017/04/21.
//  Copyright © 2017 Private. All rights reserved.
//

import XCTest
import MapKit

class GoogleStateReducerTests: XCTestCase {
    
    var serviceUnderTest: GoogleStateReducer!
    
    let errorState: GoogleState = {
        var state = GoogleState()
        state.errorMessage = "This is an errorMessage"
        return state
    }()
    
    let loadingState: GoogleState = {
        var state = GoogleState()
        state.isLoadingData = true
        return state
    }()
    
    override func setUp() {
        super.setUp()
        serviceUnderTest = GoogleStateReducer()
    }
    
    func testDefaultValuesForNewStateObject() {
        let result = GoogleState()
        
        XCTAssertFalse(result.isLoadingData)
        XCTAssertNil(result.errorMessage)
        XCTAssertTrue(result.places.count == 0)
        XCTAssertTrue(result.photos.count == 0)
    }
    
    func testThatIsLoadingWhenGettingPlacesAroundCurrentLocation() {
        let result = serviceUnderTest.reduce(GoogleState(), .getPlacesAroundCurrentLocation)
        
        XCTAssertTrue(result.isLoadingData)
        XCTAssertNil(result.errorMessage)
    }
    
    func testThatIsLoadingWhenReloadingPlacesAroundCurrentLocation() {
        let result = serviceUnderTest.reduce(GoogleState(), .reloadPlacesAroundCurrentLocation)
        
        XCTAssertTrue(result.isLoadingData)
        XCTAssertNil(result.errorMessage)
    }
    
    func testThatResetsErrorMessageWhenReloadingPlacesAroundCurrentLocation() {
        let result = serviceUnderTest.reduce(errorState, .reloadPlacesAroundCurrentLocation)
        
        XCTAssertTrue(result.isLoadingData)
        XCTAssertNil(result.errorMessage)
    }
    
    func testThatIsLoadingWhenGettingPhotosForPlace() {
        let result = serviceUnderTest.reduce(GoogleState(), .getPhotosForSelectedPlace)
        
        XCTAssertTrue(result.isLoadingData)
        XCTAssertNil(result.errorMessage)
    }
    
    func testThatErrorMessageIsPopulatedWhenErrorOccurs() {
        let errorMessage = "This is an error message"
        
        let result = serviceUnderTest.reduce(loadingState, .errorOccurred(errorMessage))
        
        XCTAssertFalse(result.isLoadingData)
        XCTAssertEqual(errorMessage, result.errorMessage)
    }
    
    func testThatFinishedLoadingWhenRetrievedPlaces() {
        let place = PlaceStub("test")
        
        let result = serviceUnderTest.reduce(loadingState, .retrievedPlaces([place]))
        
        XCTAssertFalse(result.isLoadingData)
        XCTAssertNil(result.errorMessage)
        XCTAssertTrue(result.places.count == 1)
        XCTAssertEqual(place.id, result.places[0].id)
    }
    
    func testThatFinishedLoadingWhenRetrievedPhotos() {
        let photo = PhotoStub("test")
        
        let result = serviceUnderTest.reduce(loadingState, .retrievedPhotos([photo]))
        
        XCTAssertFalse(result.isLoadingData)
        XCTAssertNil(result.errorMessage)
        XCTAssertTrue(result.photos.count == 1)
        XCTAssertEqual(photo.id, result.photos[0].id)
    }
    
}
