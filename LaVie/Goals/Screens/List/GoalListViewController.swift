//
//  ViewController.swift
//  LaVie
//
//  Created by Bruno Barreira on 20/02/19.
//  Copyright © 2019 Bruno Barreira. All rights reserved.
//

import UIKit
import Firebase
import RxCocoa
import RxSwift

class GoalListViewController: UIViewController, LVTabbable {
    var tableView: UITableView!
    var viewModel: GoalListViewModel!
        
    override func viewDidLoad() {
        super.viewDidLoad()
        managerDidLoad()
        setup()
    }
    
    func fetchData() {
        GoalApi.getGoals(onSuccess: viewModel.accept(_:))
    }

    override func viewWillAppear(_ animated: Bool) {
        fetchData()
    }
    
    func setupNavigationBar() {
        self.navigationItem.rightBarButtonItems = [UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(pushAddViewController))]
    }
    
    @objc func pushAddViewController() {
        self.navigationController?.present(UINavigationController(rootViewController: GoalCreateViewController(title: i18n("new_goal"))), animated: true)
    }
    
    func pushShowViewController(_ goal: Goal) {
        self.navigationController?.pushViewController(GoalShowViewController(goal: goal), animated: true)
    }
    
    func setup() {
        setupNavigationBar()
        setupTableView()
        setupViewModel()
    }
    
    func setupTableView() {
        tableView = UITableView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height))
        tableView.backgroundColor = UIColor(red:0.94, green:0.94, blue:0.96, alpha:1.0)
        tableView.separatorStyle = .none
        tableView.on(refresh: fetchData)
        view.addSubview(tableView)
    }
    
    func setupViewModel() {
        viewModel = GoalListViewModel(tableView: tableView)
        viewModel.on(selected: pushShowViewController(_:))
        viewModel.setup()
    }
    
}

