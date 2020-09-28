//
//  OpenImageViewModel.swift
//  PixabayImageViewer
//
//  Created by shubham Garg on 27/09/20.
//  Copyright © 2020 Shubh. All rights reserved.
//

import Foundation
import RxSwift
class OpenImageViewModel {
    private var selectedIndex: Int
    var mediaDataManager: LocalDataManager
    public let error : PublishSubject<DataError>
    var medias:Medias
    init(selectedIndex: Int) {
        mediaDataManager = MediaLocalDataManager.shared
        self.selectedIndex = selectedIndex
        medias = self.mediaDataManager.getData()
        error = PublishSubject()
    }
    
    //MARK: get selected image
    func getSelectedImage()->String{
        return medias[selectedIndex].largeImageURL ?? ""
    }
    
    //MARK: get image on right swipe
    func getRightImage()->String?{
        if selectedIndex <= 0 {
            self.error.onNext(.serverMessage(NO_DATA_FOUND))
        }
        else{
           selectedIndex -= 1
           return self.getSelectedImage()
        }
        return nil
    }
    //MARK: Get image of left swipe
    func getLeftImage()->String?{
        if selectedIndex <  medias.count - 1{
            selectedIndex += 1
            return self.getSelectedImage()
        }
        else{
           //TODO: We also can go for pagination request and update local medias object
           self.error.onNext(.serverMessage(NO_DATA_FOUND))
        }
        return nil
    }
}
