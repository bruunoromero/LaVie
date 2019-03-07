//
//  GoalListViewModel.swift
//  LaVie
//
//  Created by Bruno Barreira on 05/03/19.
//  Copyright © 2019 Bruno Barreira. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class GoalListViewModel {
    var tableView: UITableView!
    let cellId = "GoalListCell"
    let disposeBag = DisposeBag()
    let goals: BehaviorRelay<[Goal]> = BehaviorRelay(value: [])

    init(tableView: UITableView) {
        self.tableView = tableView
    }
    
    func setup() {
        setupTableView()
        subscribe()
    }
    
    private func setupTableView() {
        tableView.register(GoalCell.self, forCellReuseIdentifier: cellId)
    }
    
    private func subscribe() {
        goals
            .asObservable()
            .bind(to: tableView.rx.items(cellIdentifier: cellId, cellType: GoalCell.self)) { [unowned self] row, goal, cell in
                self.bind(goal, to: cell)
            }
            .disposed(by: disposeBag)
    }
    
    private func bind(_ goal: Goal, to cell: GoalCell) {
        cell.cardTitle.text = goal.title
        cell.cardIcon.image = AspectManager.icon(from: goal.aspect)
        cell.dueDate.text = goal.dueDate.short
        cell.goalProgress.setProgress(goal.progress / 100, animated: true)
        cell.progressLabel.text = "\(goal.progress)% \(i18n("completed"))"
    }
    
    func accept(_ goals: [Goal]) {
        self.goals.accept(goals)
    }
    
    func on(selected: @escaping (Goal) -> Void) {
        tableView.rx.modelSelected(Goal.self).subscribe(onNext: { element in
            selected(element)
        }).disposed(by: disposeBag)
    }
}
