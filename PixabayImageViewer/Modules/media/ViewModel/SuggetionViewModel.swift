//
//  SuggetionViewModel.swift
//  PixabayImageViewer
//
//  Created by shubham Garg on 27/09/20.
//  Copyright © 2020 Shubh. All rights reserved.
//

import Foundation
import RxSwift

class SuggetionViewModel{
    public let suggetions: PublishSubject<[String]>
    var suggestionDataManager: LocalDataManager
    
    init() {
        suggestionDataManager = SuggestionCoreDataManager()
        suggetions = PublishSubject()
    }
    
    //MARK: get suggtion from local
    func getSuggetion(){
        self.suggetions.onNext(getSuggetionFromDB())
    }
    
    func getSuggetionFromDB() -> [String] {
        return suggestionDataManager.getData(count: 10)
    }
    
    //MARK: save suggtion in local
    func saveSuggetionToDB(searchText: String){
        suggestionDataManager.saveData(data: searchText)
    }
}
