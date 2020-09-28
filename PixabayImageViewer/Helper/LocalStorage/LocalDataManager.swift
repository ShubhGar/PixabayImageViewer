//
//  LocalDataManager.swift
//  PixabayImageViewer
//
//  Created by shubham Garg on 27/09/20.
//  Copyright © 2020 Shubh. All rights reserved.
//

import Foundation

protocol LocalDataManager {
    func getData<T:Codable>(count: Int)->[T]
    func getData<T:Codable>()->[T]
    func saveData<T:Codable>(data:T)
    func saveDataArray<T:Codable>(data:[T])
    func deleteAllData()
}

extension LocalDataManager{
    func getData<T>() -> [T] where T : Decodable, T : Encodable {
        return []
    }
    
}
