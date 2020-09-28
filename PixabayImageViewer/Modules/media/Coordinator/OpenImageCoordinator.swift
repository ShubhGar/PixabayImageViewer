//
//  OpenImageCoordinator.swift
//  PixabayImageViewer
//
//  Created by shubham Garg on 27/09/20.
//  Copyright © 2020 Shubh. All rights reserved.
//

import Foundation
import UIKit
import RxSwift

class OpenImageCoordinator: BaseCoordinator<String> {
    private let rootViewController: UIViewController
    private let selectedIndex: Int
    
    init(selectedIndex: Int, rootViewController: UIViewController) {
        self.selectedIndex = selectedIndex
        self.rootViewController = rootViewController
    }
    
    //Initialise and present full screen image and its dependecies
    override func start() -> Observable<CoordinationResult> {
        let viewController = OpenImageViewController.initFromStoryboard()
        let viewModel = OpenImageViewModel(selectedIndex: selectedIndex)
        viewController.viewModel = viewModel
        viewController.modalPresentationStyle = .fullScreen
        rootViewController.navigationController?.present(viewController, animated: true, completion: nil)
        return Observable.never()
    }
    
}
