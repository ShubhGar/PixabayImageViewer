//
//  SuggetionViewController.swift
//  PixabayImageViewer
//
//  Created by shubham Garg on 27/09/20.
//  Copyright © 2020 Shubh. All rights reserved.
//

import UIKit
import RxSwift
class SuggetionViewController: UIViewController,StoryboardInitializable {
    @IBOutlet private weak var suggetionTableView: UITableView!
    public var suggetions = PublishSubject<[String]>()
    private let disposeBag = DisposeBag()
    var suggetionSelected: PublishSubject<String>?
    // MARK: - View's Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setUPTableView()
    }
    
    // MARK: - Tableview look up
    private func setUPTableView(){
        suggetionTableView.backgroundColor = .clear
        suggetionTableView.tableFooterView = UIView(frame: .zero)
        suggetionTableView.register(UITableViewCell.self, forCellReuseIdentifier: UITableViewCell.viewIdentifier)
    }
    // MARK: - Bindings
    func setupBinding(){
        suggetions.bind(to: suggetionTableView.rx.items(cellIdentifier: UITableViewCell.viewIdentifier, cellType: UITableViewCell.self)) {  (row,suggetion,cell) in
            cell.textLabel?.text = suggetion
            cell.selectionStyle = .none
        }.disposed(by: disposeBag)
        if let suggetionSelected = self.suggetionSelected{
            suggetionTableView.rx.modelSelected(String.self)
                .bind(to: suggetionSelected)
                .disposed(by: disposeBag)
        }
    }
    
}
