//
//  OpenImageViewController.swift
//  PixabayImageViewer
//
//  Created by shubham Garg on 27/09/20.
//  Copyright © 2020 Shubh. All rights reserved.
//

import UIKit
import RxSwift

class OpenImageViewController: UIViewController, StoryboardInitializable {
    @IBOutlet weak var fullImageView: UIImageView!
    var viewModel: OpenImageViewModel?
    var loading: PublishSubject<Bool> = PublishSubject()
    let disposeBag = DisposeBag()
    // MARK: - View's Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupBinding()
        self.addSwipeGesture()
        self.setImage(image: viewModel?.getSelectedImage() ?? "")
    }
    // MARK: - Bindings
    func setupBinding(){
        loading.bind(to: self.rx.isAnimating).disposed(by: disposeBag)
        viewModel?.error.observeOn(MainScheduler.instance)
        .subscribe(onNext: { (error) in
            self.showError(error: error)
        }).disposed(by: disposeBag)
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
    //Mark:- Add left and right gesture
    func addSwipeGesture(){
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(self.respondToSwipeGesture))
        swipeRight.direction = UISwipeGestureRecognizer.Direction.right
        self.view.addGestureRecognizer(swipeRight)
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(self.respondToSwipeGesture))
        swipeLeft.direction = UISwipeGestureRecognizer.Direction.left
        self.view.addGestureRecognizer(swipeLeft)
    }
    
    //Mark:- Set image from url
    //Here we are using SdWebImage to maintain cache but we can use UrlSession and main a cache by saving image on Sandbox(using filemanager) and the key and path in user default or core data.
    func setImage(image:String){
      if let url = URL(string: image){
        self.loading.onNext(true)
        fullImageView.sd_setImage(with: url, completed: { (_, error, _, _) in
            if let error = error{
                self.showError(error: DataError.internetError(error.localizedDescription))
            }
           self.loading.onNext(false)
        })
        }
    }
    
    //MARK:- Dismiss Full image view on cancel Button
    //TODO: Use ios 13 System image for cancel button but for support lower version we need to add own
    @IBAction func cancelBtnAxn(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    // Action on swipe
    @objc func respondToSwipeGesture(gesture: UIGestureRecognizer) {
        if let swipeGesture = gesture as? UISwipeGestureRecognizer {
            switch swipeGesture.direction {
            case UISwipeGestureRecognizer.Direction.right:
                if let image = self.viewModel?.getRightImage(){
                    self.setImage(image: image)
                }
                break
            case UISwipeGestureRecognizer.Direction.left:
                if let image = self.viewModel?.getLeftImage(){
                    self.setImage(image: image)
                }
                break
            default:
                break
            }
        }
    }
   
}
