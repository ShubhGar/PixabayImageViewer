//
//  AppCoordinator.swift
//  PixabayImageViewer
//
//  Created by Shubham Garg on 27/09/20.
//  Copyright © 2020 Shubh. All rights reserved.
//

import UIKit
import RxSwift

//Coordinater to start peresenting screen
class AppCoordinator: BaseCoordinator<Void> {
    
    private let window: UIWindow
    
    init(window: UIWindow) {
        self.window = window
    }
    
    //Starts job of the coordinator
    override func start() -> Observable<Void> {
        let repositoryListCoordinator = HomeViewCoordinator(window: window)
        return coordinate(to: repositoryListCoordinator)
    }
}
