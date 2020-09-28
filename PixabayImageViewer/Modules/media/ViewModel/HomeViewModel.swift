//
//  HomeViewModel.swift
//  PixabayImageViewer
//
//  Created by Shubham Garg on 27/09/20.
//  Copyright © 2020 Shubh. All rights reserved.
//
//

import Foundation
import RxSwift

typealias MediaViewModels = [MediaViewModel]
class HomeViewModel {
    public let medias : PublishSubject<MediaViewModels>
    public let loading: PublishSubject<Bool>
    public let error : PublishSubject<DataError>
    let selectIndex: AnyObserver<Int>
    let showFullImage: Observable<Int>
    var pageNumber = 1
    var per_page = 20
    var dataFetcher:DataFetcherProtocol
    private let disposable = DisposeBag()
    var mediaDataManager: LocalDataManager
    
    init(){
        dataFetcher = NetworkDataFetcher()
        mediaDataManager = MediaLocalDataManager.shared
        medias = PublishSubject()
        loading = PublishSubject()
        error = PublishSubject()
        let _selectIndex = PublishSubject<Int>()
        self.selectIndex = _selectIndex.asObserver()
        self.showFullImage = _selectIndex.asObservable().compactMap { $0 }
    }
    
    //MARK: load more paginated data
    public func loadNextData(searchText: String){
        let medias:Medias = self.mediaDataManager.getData()
        if self.pageNumber * per_page <= medias.count{
            self.pageNumber += 1
            self.fetchDataFromServer(search: searchText)
        }
    }
    
    //MARK: fetch data in Initial call
    public func requestData(searchText: String){
        self.mediaDataManager.deleteAllData()
        self.medias.onNext([])
        self.pageNumber = 1
        self.fetchDataFromServer(search: searchText)
    }
    
    //MARK: Fetch data
    private func fetchDataFromServer(search: String){
        self.loading.onNext(true)
        let parameters = ["image_type": "photo", "q": search, "page": pageNumber, "key" : KEY, "per_page": per_page] as [String : Any]
        if let url = createURL(params: parameters){
            dataFetcher.requestData(url: url) { (result:ApiResult<SearchResult>) in
                self.loading.onNext(false)
                switch result {
                case .success(let obj) :
                    self.parseSuccess(dataObj: obj)
                case .failure(let failure) :
                    self.parseFailure(failure: failure)
                }
            }
        }
    }
    
    //MARK: Parse Success of  data fetch
    func parseSuccess(dataObj: SearchResult){
        self.mediaDataManager.saveDataArray(data: dataObj.hits ?? [])
        let medias:Medias = self.mediaDataManager.getData()
        let mediaList:MediaViewModels = medias.map{
            return MediaViewModel(media: $0)
        }
        self.medias.onNext(mediaList)
    }
    
    //MARK: Parse failure of data fetch
    func parseFailure(failure: RequestError){
        switch failure {
        case .connectionError:
            self.error.onNext(.internetError(INTERNET_ERROR))
        case .authorizationError(let error):
            self.error.onNext(.serverMessage(error))
        case .noDataFound:
            self.error.onNext(.serverMessage(NO_DATA_FOUND))
        default:
            self.error.onNext(.serverMessage(UNKNOWN_ERROR))
        }
    }
    
}

