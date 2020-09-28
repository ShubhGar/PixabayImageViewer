//
//  OpenImageViewModelTests.swift
//  PixabayImageViewerTests
//
//  Created by shubham Garg on 28/09/20.
//  Copyright © 2020 Shubh. All rights reserved.
//

import XCTest
@testable import PixabayImageViewer

class OpenImageViewModelTests: XCTestCase {
    var stubbedModel:OpenImageViewModel!
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        let medias = [MediaDetail(id: nil, previewWidth: 100, previewHeight: 100, downloads: 0, views: 0, favorites: 0, likes: 0, comment: 0, user_id: 1, pageURL: "", type: "", tags: "", previewURL: "", largeImageURL: "", user: "", userImageURL: ""),MediaDetail(id: nil, previewWidth: 100, previewHeight: 100, downloads: 0, views: 0, favorites: 0, likes: 0, comment: 0, user_id: 1, pageURL: "", type: "", tags: "", previewURL: "", largeImageURL: "", user: "", userImageURL: ""),MediaDetail(id: nil, previewWidth: 100, previewHeight: 100, downloads: 0, views: 0, favorites: 0, likes: 0, comment: 0, user_id: 1, pageURL: "", type: "", tags: "", previewURL: "", largeImageURL: "", user: "", userImageURL: "")]
        stubbedModel = OpenImageViewModel(selectedIndex: 1)
        stubbedModel.medias = medias
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        stubbedModel =  nil
    }
    
    func testGetSelectedImage(){
        let imageUrl =  stubbedModel.getSelectedImage()
        XCTAssertNotNil(imageUrl)
    }
    
    func testGetRightImage(){
        let imageUrl =  stubbedModel.getRightImage()
        XCTAssertNotNil(imageUrl)
    }
    
    func testGetLeftImage(){
        let imageUrl =  stubbedModel.getLeftImage()
        XCTAssertNotNil(imageUrl)
    }

    func testPerformanceGetSelectedImage() throws {
        // This is an example of a performance test case.
        self.measure {
           _ = stubbedModel.getSelectedImage()
        }
    }
    
    func testPerformanceGetLeftImage() throws {
        // This is an example of a performance test case.
        self.measure {
           _ = stubbedModel.getLeftImage()
        }
    }
    
    func testPerformanceGetRightImage() throws {
        // This is an example of a performance test case.
        self.measure {
           _ = stubbedModel.getRightImage()
        }
    }
}
