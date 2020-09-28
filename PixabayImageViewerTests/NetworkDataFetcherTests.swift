//
//  NetworkDataFetcherTests.swift
//  PixabayImageViewerTests
//
//  Created by shubham Garg on 28/09/20.
//  Copyright © 2020 Shubh. All rights reserved.
//

import XCTest
@testable import PixabayImageViewer

class NetworkDataFetcherTests: XCTestCase {
    
    var dataFetcher:DataFetcherProtocol?
    override func setUp() {
        dataFetcher = NetworkDataFetcher()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        dataFetcher = nil
    }

    func testRequestDataWithIncorrectURL() {
        let expect = XCTestExpectation(description: "callback")
        dataFetcher?.requestData(url: URL(string: BASE_URL + "?page=")!, completion: { (result:ApiResult<SearchResult>) in
            expect.fulfill()
            switch result {
            case .success( _) :
                XCTAssertTrue(false)
            case .failure( _) :
               XCTAssertTrue(true)
                break
            }
        })
        wait(for: [expect], timeout: 60.0)
    }
    
    func testRequestDataWithSuccess() {
        let expect = XCTestExpectation(description: "callback")
        let parameters = ["image_type": "photo", "q": "car", "page": 1, "key" : KEY, "per_page": 20] as [String : Any]
        let url = createURL(params: parameters)
        dataFetcher?.requestData(url: url!, completion: { (result:ApiResult<SearchResult>) in
            expect.fulfill()
            switch result {
            case .success( let data) :
                XCTAssertNotNil(data)
            case .failure( _) :
               XCTAssertTrue(false)
                break
            }
        })
        wait(for: [expect], timeout: 60.0)
    }

}
