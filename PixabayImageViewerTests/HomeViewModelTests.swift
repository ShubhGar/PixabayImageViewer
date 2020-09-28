//
//  HomeViewModelTests.swift
//  PixabayImageViewerTests
//
//  Created by shubham Garg on 28/09/20.
//  Copyright © 2020 Shubh. All rights reserved.
//

import XCTest

@testable import PixabayImageViewer

class HomeViewModelTests: XCTestCase {
    
    var mockVMObj:HomeViewModelMock!

    override func setUp() {
        self.mockVMObj = HomeViewModelMock()
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        self.mockVMObj = nil
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

}
