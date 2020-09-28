//
//  MediaViewModel.swift
//  PixabayImageViewer
//
//  Created by Shubham Garg on 27/09/20.
//  Copyright © 2020 Shubh. All rights reserved.
//

import Foundation
import UIKit

class MediaViewModel {
    let userName: String
    let previewImageURL: String
    let previewWidth: Int
    var previewHeight: Int
    let largeImageURL:String
    
    init(media: MediaDetail) {
        self.userName = media.user ?? ""
        self.largeImageURL = media.largeImageURL ?? ""
        self.previewImageURL = media.previewURL ?? ""
        self.previewWidth = media.previewWidth ?? 0
        self.previewHeight = media.previewHeight ?? 0
    }
    
    //MARK: get height of imageview in aspected ratio
    func imageAspectHeight()-> CGFloat{
        let width = UIScreen.main.bounds.width - 32
        return width * CGFloat(previewHeight) / CGFloat(previewWidth)
    }
  
}
