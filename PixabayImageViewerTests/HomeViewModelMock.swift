//
//  UserDataViewerProtocolMock.swift
//  PixabayImageViewerTests
//
//  Created by shubham Garg on 28/09/20.
//  Copyright © 2020 Shubh. All rights reserved.
//

import Foundation
import XCTest
@testable import PixabayImageViewer

class HomeViewModelMock:HomeViewModel {
     // Setting .None is unnecessary, but helps with clarity imho
    var asyncBool: Bool?
    var asyncExpectation: XCTestExpectation?
    
    override func parseSuccess(dataObj: SearchResult){
        guard let expectation = asyncExpectation else {
          XCTFail("Not setup correctly")
          return
        }
        asyncBool = true
        expectation.fulfill()
    }
    override func parseFailure(failure: RequestError){
        guard let expectation = asyncExpectation else {
          XCTFail("Not setup correctly")
          return
        }
        asyncBool = false
        expectation.fulfill()
    }

}
