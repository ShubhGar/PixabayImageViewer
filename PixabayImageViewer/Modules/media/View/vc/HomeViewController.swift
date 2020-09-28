//
//  HomeViewController.swift
//  PixabayImageViewer
//
//  Created by Shubham Garg on 27/09/20.
//  Copyright © 2020 Shubh. All rights reserved.
//

import UIKit
import RxSwift

class HomeViewController: UIViewController,StoryboardInitializable {
    @IBOutlet weak var childVCView: UIView!
    private lazy var searchBar:UISearchBar = UISearchBar()
    var homeViewModel: HomeViewModel?
    var suggetionViewModel: SuggetionViewModel?
    let disposeBag = DisposeBag()
    
    //MARK:- Chlid view controller to present media List
    private lazy var mediasViewController: MediaTableViewController = {
        var viewController = MediaTableViewController.initFromStoryboard()
        viewController.selectedIndex = PublishSubject<Int>()
        viewController.selectedIndex?.subscribe(onNext: { [weak self] in
            self?.homeViewModel?.selectIndex.onNext($0)
        }).disposed(by: disposeBag)
        viewController.loadNext = PublishSubject<Bool>()
        viewController.loadNext?.observeOn(MainScheduler.instance).subscribe(onNext: { (next) in
            if let text = self.searchBar.text{
                self.homeViewModel?.loadNextData(searchText: text)
            }
        }).disposed(by: disposeBag)
        self.add(asChildViewController: viewController, to: childVCView)
        viewController.setupBinding()
        return viewController
    }()
    
    //MARK:- Chlid view controller to present suggetion
    private lazy var suggetionViewController: SuggetionViewController = {
        var viewController = SuggetionViewController.initFromStoryboard()
        viewController.suggetionSelected = PublishSubject<String>()
        viewController.suggetionSelected?.subscribe(onNext: { [weak self] (suggestion) in
            self?.searchBar.resignFirstResponder()
            self?.view.endEditing(true)
            self?.homeViewModel?.requestData(searchText:  suggestion)
        }).disposed(by: disposeBag)
        self.add(asChildViewController: viewController, to: childVCView)
        viewController.setupBinding()
        return viewController
    }()
    
    // MARK: - View's Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupBindings()
        self.addSearchBar()
    }
    // MARK: - Add search bar on navigation bar
    func addSearchBar(){
        navigationController?.setNavigationBarHidden(false, animated: true)
        searchBar.searchBarStyle = UISearchBar.Style.prominent
        searchBar.placeholder = " Search..."
        searchBar.sizeToFit()
        searchBar.isTranslucent = false
        searchBar.backgroundImage = UIImage()
        searchBar.delegate = self
        navigationItem.titleView = searchBar
    }
    
    // MARK: - Bindings
    private func setupBindings() {
        homeViewModel?.loading.bind(to: self.rx.isAnimating).disposed(by: disposeBag)
        
        homeViewModel?.error.observeOn(MainScheduler.instance)
            .subscribe(onNext: { (error) in
                self.showError(error: error)
            }).disposed(by: disposeBag)
        
        homeViewModel?.medias.observeOn(MainScheduler.instance).bind(to: mediasViewController.medias).disposed(by: disposeBag)
        
        homeViewModel?.medias.observeOn(MainScheduler.instance).subscribe(onNext: { (error) in
            self.showSearchResult()
        }).disposed(by: disposeBag)
        
        suggetionViewModel?.suggetions.observeOn(MainScheduler.instance).bind(to: suggetionViewController.suggetions).disposed(by: disposeBag)
    }
    //Mark:- Show error popup
    func showError(error:DataError){
        switch error {
        case .internetError(let message):
            MessageView.sharedInstance.showOnView(message: message, theme: .error)
        case .serverMessage(let message):
            MessageView.sharedInstance.showOnView(message: message, theme: .warning)
        }
    }
    
    //Mark:- Show respected screens
    func showSuggtion(){
        self.children.forEach({ $0.willMove(toParent: nil); $0.view.removeFromSuperview(); $0.removeFromParent() })
        self.add(asChildViewController: suggetionViewController, to: childVCView)
    }
    
    func showSearchResult(){
        if let searchText = self.searchBar.text{
            self.suggetionViewModel?.saveSuggetionToDB(searchText: searchText)
        }
        self.children.forEach({ $0.willMove(toParent: nil); $0.view.removeFromSuperview(); $0.removeFromParent() })
        self.add(asChildViewController: mediasViewController, to: childVCView)
    }
    
}

//MARK:- Search bar delegate
extension HomeViewController: UISearchBarDelegate{
    func searchBar(_ searchBar: UISearchBar, textDidChange textSearched: String)
    {
        NSObject.cancelPreviousPerformRequests(withTarget: self, selector: #selector(hitServiceFromSearchText), object: nil)
        if !textSearched.isEmpty{
            self.perform(#selector(hitServiceFromSearchText), with: nil, afterDelay: 0.5)
        }
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.setShowsCancelButton(true, animated: true)
        self.showSuggtion()
        self.suggetionViewModel?.getSuggetion()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.setShowsCancelButton(false, animated: true)
        searchBar.text = ""
        searchBar.endEditing(true)
        self.searchBar(searchBar, textDidChange:"")
        self.showSearchResult()
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchBar.setShowsCancelButton(false, animated: true)
    }
    
    @objc func hitServiceFromSearchText() {
        if let text = searchBar.text, !text.isEmpty{
            mediasViewController.setContentOffsetToZero()
            homeViewModel?.requestData(searchText:  text)
        }
    }
}
