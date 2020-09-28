//
//  UserDataViewerProtocolMock.swift
//  MVVMRxCoordinatorTests
//
//  Created by shubham Garg on 28/09/20.
//  Copyright © 2020 Shubh. All rights reserved.
//

import Foundation
import XCTest
@testable import MVVMRxCoordinator

class HomeViewModelMock {
     // Setting .None is unnecessary, but helps with clarity imho
    var asyncBool: Bool?
    var asyncExpectation: XCTestExpectation?
    func updateUsers(users: UserViewModels) {
        guard let expectation = asyncExpectation else {
          XCTFail("Not setup correctly")
          return
        }
        asyncBool = true
        expectation.fulfill()
    }
    func showError(message: String) {
        guard let expectation = asyncExpectation else {
          XCTFail("Not setup correctly")
          return
        }
        asyncBool = false
        expectation.fulfill()
    }

}
