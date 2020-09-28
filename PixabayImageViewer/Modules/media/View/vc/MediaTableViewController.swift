//
//  MediaTableViewController.swift
//  PixabayImageViewer
//
//  Created by Shubham Garg on 27/09/20.
//  Copyright © 2020 Shubh. All rights reserved.
//

import UIKit
import RxSwift


class MediaTableViewController: UIViewController,StoryboardInitializable {
    @IBOutlet private weak var mediaTableView: UITableView!
    
    public var medias = PublishSubject<[MediaViewModel]>()
    private let disposeBag = DisposeBag()
    var selectedIndex: PublishSubject<Int>?
    var loadNext: PublishSubject<Bool>?
    
    // MARK: - View's Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUPTableView()
    }
    // MARK: - Tableview look up
    private func setUPTableView(){
        mediaTableView.backgroundColor = .clear
        mediaTableView.tableFooterView = UIView(frame: .zero)
        mediaTableView.register(UINib(nibName: MediaTableViewCell.viewIdentifier, bundle: nil), forCellReuseIdentifier: MediaTableViewCell.viewIdentifier)
    }
    // MARK: - Bindings
    func setupBinding(){
        medias.bind(to: mediaTableView.rx.items(cellIdentifier: MediaTableViewCell.viewIdentifier, cellType: MediaTableViewCell.self)) {  (row,media,cell) in
            self.setupCell(cell, media: media)
        }.disposed(by: disposeBag)
        mediaTableView.rx.willDisplayCell.subscribe(onNext: { cell, indexPath in
            if indexPath.row == self.mediaTableView.numberOfRows(inSection: 0) - 1{
                self.loadNext?.onNext(true)
            }
        }).disposed(by: disposeBag)
        mediaTableView.rx.itemSelected.subscribe(onNext: { [weak self] indexPath in
            self?.selectedIndex?.onNext(indexPath.row)
        }).disposed(by: disposeBag)
    }
    
    // MARK: - Move to top
    func setContentOffsetToZero(){
        mediaTableView?.setContentOffset(CGPoint(x: 0, y: 0), animated: false)
    }
    
    // MARK: - fill cell data
    private func setupCell(_ cell: MediaTableViewCell, media: MediaViewModel) {
        cell.selectionStyle = .none
        cell.set(name: media.userName)
        cell.set(imageUrl: media.previewImageURL,aspectHeight: media.imageAspectHeight())
    }
    
}
