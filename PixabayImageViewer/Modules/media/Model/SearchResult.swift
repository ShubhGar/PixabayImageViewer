//
//  SearchResult.swift
//  PixabayImageViewer
//
//  Created by Shubham Garg on 27/09/20.
//  Copyright © 2020 Shubh. All rights reserved.
//

import Foundation


struct SearchResult: Codable {
    
    let total, totalHits:Int?
    let hits: [MediaDetail]?
}

struct MediaDetail:Codable{
    let id, previewWidth, previewHeight, downloads, views, favorites, likes, comment, user_id: Int?
    let pageURL, type, tags, previewURL, largeImageURL, user, userImageURL: String?
}

typealias Medias = [MediaDetail]
