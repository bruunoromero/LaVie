//
//  GoalViewController.swift
//  LaVie
//
//  Created by Bruno Barreira on 24/02/19.
//  Copyright © 2019 Bruno Barreira. All rights reserved.
//

import UIKit
import Eureka
import RxSwift
import RxCocoa
import Firebase

class GoalShowViewController: UIViewController, LVPushable {
    var goal: Goal!
    var tableView: UITableView!
    var viewModel: GoalShowViewModel!
    var actions: Observable<[Action]>!

    convenience init(goal: Goal) {
        self.init(title: goal.title)
        
        self.goal = goal
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        managerDidLoad()
        setupNavigationBar()
        setupForm()
    }

    func setupNavigationBar() {
        navigationItem.rightBarButtonItems = [UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(editGoal))]
    }

    @objc func editGoal() {

    }

    func setupForm() {
        setupTableView()
        setupViewModel()
    }
    
    func setupTableView() {
        tableView = UITableView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height))
        tableView.backgroundColor = UIColor(red:0.94, green:0.94, blue:0.96, alpha:1.0)
        tableView.separatorStyle = .none
        
        view.addSubview(tableView)
    }
    
    func setupViewModel() {
        viewModel = GoalShowViewModel(tableView: tableView)
        viewModel.setup()
        
        let notDoneActions = goal.actions.filter { !$0.isDone }
        let doneActions = goal.actions.filter { $0.isDone }
        
        viewModel.accept(event: [
            ActionSectionModel(header: "\(i18n("not_done_p")) (\(notDoneActions.count))", items: notDoneActions),
            ActionSectionModel(header: "\(i18n("done_p")) (\(doneActions.count))", items: doneActions)
        ])
    }
}
