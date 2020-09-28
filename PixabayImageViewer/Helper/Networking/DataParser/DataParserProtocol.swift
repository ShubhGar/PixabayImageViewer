//
//  DataParserProtocol.swift
//  PixabayImageViewer
//
//  Created by shubham Garg on 27/09/20.
//  Copyright © 2020 Shubh. All rights reserved.
//

import Foundation

protocol DataParserProtocol {
    func parse<T:Codable>(data: Data)-> T?
}
