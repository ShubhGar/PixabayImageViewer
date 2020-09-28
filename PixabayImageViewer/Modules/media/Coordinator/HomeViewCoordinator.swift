//
//  HomeViewCoordinator.swift
//  PixabayImageViewer
//
//  Created by Shubham Garg on 27/09/20.
//  Copyright © 2020 Shubh. All rights reserved.
//
import UIKit
import RxSwift
import SafariServices

//Set up homeview
class HomeViewCoordinator: BaseCoordinator<Void> {
    
    private let window: UIWindow
    
    init(window: UIWindow) {
        self.window = window
    }
    
    //initialise and present home view and its dependecies
    override func start() -> Observable<Void> {
        let viewModel = HomeViewModel()
        let viewController = HomeViewController.initFromStoryboard()
        let navigationController = UINavigationController(rootViewController: viewController)
        viewController.suggetionViewModel = SuggetionViewModel()
        viewController.homeViewModel = viewModel
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
        
        viewModel.showFullImage.subscribe(onNext: { [weak self] in self?.showFullImage(selectedIndex: $0, in: viewController) }).disposed(by: disposeBag)
        
        return Observable.never()
    }
    
    //Open full Image Screen view
    private func showFullImage(selectedIndex :Int, in rootViewController: UIViewController) {
        let imageCoordinator = OpenImageCoordinator(selectedIndex: selectedIndex, rootViewController: rootViewController)
        _ = coordinate(to: imageCoordinator)
    }
}
