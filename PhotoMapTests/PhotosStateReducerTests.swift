//
//  PhotosStateReducerTests.swift
//  PhotoMap
//
//  Created by Justin Guedes on 2017/04/22.
//  Copyright © 2017 Private. All rights reserved.
//

import XCTest

class PhotosStateReducerTests: XCTestCase {
    
    var serviceUnderTest: PhotosStateReducer!
    
    override func setUp() {
        super.setUp()
        serviceUnderTest = PhotosStateReducer()
    }
    
    func testDefaultValuesForNewStateObject() {
        let result = PhotosState()
        
        XCTAssertNil(result.selectedPlace)
        XCTAssertEqual(-1, result.selectedPhoto)
    }
    
    func testThatSelectedPlaceIsEqualToPlacePassedThroughAction() {
        let place = PlaceStub("test")
        
        let result = serviceUnderTest.reduce(PhotosState(), .selectedPlace(place))
        
        XCTAssertEqual(place.id, result.selectedPlace?.id)
        XCTAssertEqual(-1, result.selectedPhoto)
    }
    
    func testThatSelectedPhotoIsEqualToPhotoIndexPassedThroughAction() {
        let result = serviceUnderTest.reduce(PhotosState(), .selectedPhotoAtIndex(3))
        
        XCTAssertNil(result.selectedPlace)
        XCTAssertEqual(3, result.selectedPhoto)
    }
    
}
