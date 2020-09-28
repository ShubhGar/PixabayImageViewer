//
//  IssuesTableViewController.swift
//  MVVMRxCoordinator
//
//  Created by Shubham Garg on 08/12/19.
//  Copyright © 2019 Shubh. All rights reserved.
//

import UIKit
import RxSwift


class MediaTableViewController: UIViewController,StoryboardInitializable {
    @IBOutlet private weak var issuesTableView: UITableView!
    
    public var issues = PublishSubject<[IssueViewModel]>()
    private let disposeBag = DisposeBag()
    var issueSelected: PublishSubject<Int>?
    var loadNext: PublishSubject<Bool>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUPTableView()
        setupBinding()
    }
    
    func setUPTableView(){
        issuesTableView.backgroundColor = .clear
        issuesTableView.tableFooterView = UIView(frame: .zero)
        issuesTableView.register(UINib(nibName: IssueTableViewCell.viewIdentifier, bundle: nil), forCellReuseIdentifier: String(describing: IssueTableViewCell.self))
    }
    
    private func setupBinding(){
        issues.bind(to: issuesTableView.rx.items(cellIdentifier: IssueTableViewCell.viewIdentifier, cellType: IssueTableViewCell.self)) {  (row,issue,cell) in
            self.setupIssueCell(cell, media: issue)
        }.disposed(by: disposeBag)
        issuesTableView.rx.willDisplayCell.subscribe(onNext: { cell, indexPath in
            if indexPath.row == self.issuesTableView.numberOfRows(inSection: 0) - 1{
                self.loadNext?.onNext(true)
            }
        }).disposed(by: disposeBag)
        issuesTableView.rx.itemSelected.subscribe(onNext: { [weak self] indexPath in
            self?.issueSelected?.onNext(indexPath.row)
        }).disposed(by: disposeBag)
    }
    
    func setContentOffsetToZero(){
        issuesTableView?.setContentOffset(CGPoint(x: 0, y: 0), animated: false)
    }
    
    private func setupIssueCell(_ cell: IssueTableViewCell, media: IssueViewModel) {
        cell.selectionStyle = .none
        cell.set(name: media.userName)
        cell.set(imageUrl: media.previewImageURL,aspectHeight: media.imageAspectHeight())
    }
    
}
