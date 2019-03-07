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
    let actions: BehaviorRelay<[Action]> = BehaviorRelay(value: [])
    
    init(tableView: UITableView) {
        self.tableView = tableView
        super.init(data: [])
        
        actions.bind(onNext: mapActionsToSection).disposed(by: disposeBag)
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
    
    func accept(event: [Action]) {
        actions.accept(event)
    }
    
    func on(selected: @escaping (Action) -> Void) {
        tableView.rx.modelSelected(Action.self).subscribe(onNext: { element in
            selected(element)
        }).disposed(by: disposeBag)
    }
    
    private func mapActionsToSection(actions: [Action]) {
        let notDoneActions = actions.filter { !$0.isDone }
        let doneActions = actions.filter { $0.isDone }
        
        data.accept([
            ActionSectionModel(header: "\(i18n("not_done_p")) (\(notDoneActions.count))", items: notDoneActions),
            ActionSectionModel(header: "\(i18n("done_p")) (\(doneActions.count))", items: doneActions)
        ])
    }
}
