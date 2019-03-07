//
//  GoalShowViewModel.swift
//  LaVie
//
//  Created by Bruno Barreira on 06/03/19.
//  Copyright © 2019 Bruno Barreira. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources

class GoalShowViewModel: LVViewModel<[ActionSectionModel]> {
    let cellId = "ActionCell"
    let tableView: UITableView!
    let disposeBag = DisposeBag()
    
    init(tableView: UITableView) {
        self.tableView = tableView
        super.init(data: [])
    }
    
    func setup() {
        setupTableView()
        subscribe()
    }
    
    func setupTableView() {
        tableView.register(ActionCell.self, forCellReuseIdentifier: cellId)
    }
    
    func subscribe() {
        let dataSource = RxTableViewSectionedReloadDataSource<ActionSectionModel>(configureCell: { dataSource, tableView, indexPath, action in
            let cell = tableView.dequeueReusableCell(withIdentifier: "ActionCell", for: indexPath) as! ActionCell
            cell.cardTitle.text = action.title
            return cell
        })

        dataSource.titleForHeaderInSection = { dataSource, index in
            return dataSource.sectionModels[index].header
        }
        
        data.asObservable().bind(to: tableView.rx.items(dataSource: dataSource)).disposed(by: disposeBag)
    }
}
