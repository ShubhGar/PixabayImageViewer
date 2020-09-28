//
//  SuggestionCoreDataManager.swift
//  PixabayImageViewer
//
//  Created by Shubham Garg on 27/09/20.
//  Copyright © 2020 Shubh. All rights reserved.
//

import Foundation


class SuggestionCoreDataManager: LocalDataManager{
    
    private let cdSuggestionEntity = String(describing:CDSuggestion.self)
    
    
    func getData<T>(count: Int) -> [T] where T : Decodable, T : Encodable {
        return self.getSuggtion(count: count).map{
            return ($0.searchText ?? "") as! T
        }
    }
    
    func saveData<T>(data: T) where T : Decodable, T : Encodable {
        self.save(searchText: data as! String)
    }
    
    func saveDataArray<T>(data: [T]) where T : Decodable, T : Encodable {
        for member in data{
            self.save(searchText: member as! String)
        }
    }
    
    //MARK: Save suggetion in Core Data
    func save(searchText: String){
        var cdSuggestion:CDSuggestion
        let predicate = NSPredicate(format: "searchText = %@", searchText)
        if let suggetion:CDSuggestion =  CoreDataStack.loadData(entityName: cdSuggestionEntity, predicate: predicate).first{
            cdSuggestion = suggetion
        }
        else{
            cdSuggestion = CoreDataStack.getObjectFor(entityName: cdSuggestionEntity) as! CDSuggestion
        }
        cdSuggestion.searchText = searchText
        cdSuggestion.timeStamp = Date().timeIntervalSince1970
        CoreDataStack.saveContext()
    }
    
    //MARK: get suggetion from core data
    func getSuggtion(count: Int)->[CDSuggestion]{
        let timeSort = NSSortDescriptor(key:"timeStamp", ascending:false)
        return CoreDataStack.loadData(entityName: cdSuggestionEntity, predicate: nil,sortDescriptor: timeSort, fetchLimit: count)
    }
    //MARK: Delete all suggetion
    func deleteAllData(){
        CoreDataStack.clearAllData(entityName: String(describing:CDSuggestion.self))
    }
    
}
