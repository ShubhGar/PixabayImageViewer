//
//  HomeViewControllerTests.swift
//  MVVMRxCoordinatorTests
//
//  Created by shubham Garg on 28/09/20.
//  Copyright © 2020 Shubh. All rights reserved.
//

import XCTest

@testable import MVVMRxCoordinator

class HomeViewModelTests: XCTestCase {
    
    var mockVMObj:HomeViewModelMock!

    override func setUp() {
        self.mockVMObj = HomeViewModelMock()
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testRequestData(){
        let expectation = self.expectation(description: "callback")
        self.mockVMObj.asyncExpectation = expectation
        self.mockVMObj.requestData(searchText: "car")
        
        waitForExpectations(timeout: 30) { error in
            if let error = error {
                XCTFail("waitForExpectationsWithTimeout errored: \(error)")
            }
            guard let result = self.mockVMObj.asyncBool else {
                XCTFail("Expected delegate to be called")
                return
            }
            XCTAssertTrue(result)
        }
    }
    
    func testLoadNextData(){
        let expectation = self.expectation(description: "callback")
        self.mockVMObj.asyncExpectation = expectation
        self.mockVMObj.loadNextData(searchText: "car")
        
        waitForExpectations(timeout: 30) { error in
            if let error = error {
                XCTFail("waitForExpectationsWithTimeout errored: \(error)")
            }
            guard let result = self.mockVMObj.asyncBool else {
                XCTFail("Expected delegate to be called")
                return
            }
            XCTAssertTrue(result)
        }
    }
    
    

    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
