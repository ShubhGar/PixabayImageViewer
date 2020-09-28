//
//  JsonDataParser.swift
//  PixabayImageViewer
//
//  Created by shubham Garg on 27/09/20.
//  Copyright © 2020 Shubh. All rights reserved.
//

import Foundation

// Parse json data to codable object
class JsonDataParser: DataParserProtocol {
    func parse<T>(data: Data) -> T? where T : Decodable, T : Encodable {
        do{
            return try JSONDecoder().decode(T.self, from: data)
        }
        catch{
            print(error.localizedDescription)
        }
        return nil
    }
}
