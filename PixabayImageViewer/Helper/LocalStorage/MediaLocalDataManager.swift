//
//  MediaLocalDataManager.swift
//  PixabayImageViewer
//
//  Created by shubham Garg on 27/09/20.
//  Copyright © 2020 Shubh. All rights reserved.
//

import Foundation
//Save data in in-memory array
class MediaLocalDataManager: LocalDataManager {
    var medias:Medias = []
    static var shared =  MediaLocalDataManager()
    
    private init(){
    }
    
    func getData<T>(count: Int) -> [T] where T : Decodable, T : Encodable {
        return Array(self.medias[0 ..< count]) as! [T]
    }
    
    func getData<T>() -> [T] where T : Decodable, T : Encodable {
        return self.medias as! [T]
    }
    
    func saveData<T>(data: T) where T : Decodable, T : Encodable {
        self.medias.append(data as! MediaDetail)
    }
    
    func saveDataArray<T>(data: [T]) where T : Decodable, T : Encodable {
        self.medias.append(contentsOf: data as! [MediaDetail])
    }
    
    func deleteAllData() {
        self.medias.removeAll()
    }

}
