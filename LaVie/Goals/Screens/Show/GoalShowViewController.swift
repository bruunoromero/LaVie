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
    var actions: [Action] = []
    var tableView: UITableView!
    var viewModel: GoalShowViewModel!

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
    
    override func viewWillAppear(_ animated: Bool) {
        fetchData()
    }

    func setupNavigationBar() {
        navigationItem.rightBarButtonItems = [UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(editGoal))]
    }

    @objc func editGoal() {

    }
    
    func fetchData() {
        if let id = goal.id {
            GoalApi.getActions(from: id, onSucess: { [unowned self] actions in
                self.viewModel.accept(event: actions)
            })
        }
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
    
    func updateActions(updated: Action) {
        var actions = viewModel.actions.value
        
        let oldActionIndex = actions.firstIndex { $0.id == updated.id }
        let index = oldActionIndex!
        actions[index..<index + 1] = [updated]
        self.viewModel.accept(event: actions)
        
    }
    
    func toogleIsDone(_ action: Action) {
        let newAction = Action(id: action.id, title: action.title, isDone: !action.isDone)
        ActionApi.update(action: newAction, from: goal.id!, onSuccess: { [unowned self] in
            self.updateActions(updated: newAction)
        })
        
    }
    
    func setupViewModel() {
        viewModel = GoalShowViewModel(tableView: tableView)
        viewModel.setup()
        viewModel.on(selected: toogleIsDone(_:))
        viewModel.accept(event: goal.actions ?? [])
    }
}
