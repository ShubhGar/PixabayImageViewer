//
//  MediaViewModelTest.swift
//  PixabayImageViewerTests
//
//  Created by shubham Garg on 28/09/20.
//  Copyright © 2020 Shubh. All rights reserved.
//

import XCTest
@testable import PixabayImageViewer
class MediaViewModelTest: XCTestCase {
    var stubbedModel:MediaViewModel!
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        stubbedModel = MediaViewModel(media: MediaDetail(id: nil, previewWidth: 100, previewHeight: 100, downloads: 0, views: 0, favorites: 0, likes: 0, comment: 0, user_id: 1, pageURL: "", type: "", tags: "", previewURL: "", largeImageURL: "", user: "", userImageURL: ""))
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        stubbedModel = nil
    }

    func testImageAspectHeight() throws {
        let height = stubbedModel.imageAspectHeight()
        XCTAssertTrue(height > 0)
    }

    func testPerformanceImageAspectHeight() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
            _ = stubbedModel.imageAspectHeight()
        }
    }

}
