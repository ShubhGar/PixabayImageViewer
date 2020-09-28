//
//  Apputils.swift
//  PixabayImageViewer
//
//  Created by shubham Garg on 27/09/20.
//  Copyright © 2020 Shubh. All rights reserved.
//

import Foundation

func createURL(params: [String : Any]) -> URL?{
    let url = URL(string: BASE_URL)!
    var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false)
    let queryItems = params.map{
        return URLQueryItem(name: "\($0)", value: "\($1)")
    }
    urlComponents?.queryItems = queryItems
    return urlComponents?.url
}
