//
//  ViewController.swift
//  LaVie
//
//  Created by Bruno Barreira on 20/02/19.
//  Copyright © 2019 Bruno Barreira. All rights reserved.
//

import UIKit
import Firebase
import YogaKit

class GoalListViewController: UIViewController, LVTabManager {
    var tableView: LVFlatList<Goal>!
        
    override func viewDidLoad() {
        super.viewDidLoad()
        managerDidLoad()
        setupLayout()
    }
    
    func fetchData(tableView: LVFlatList<Goal>) {
        Firestore.firestore().collection("goals").getDocuments { snapshot, error in
            if let _ = error {
                
            } else {
                let data = snapshot!.documents.map { document in
                    return Goal(from: document)
                }
                
                tableView.update(data: data)
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        fetchData(tableView: tableView)
    }
    
    func setupNavigationBar() {
        self.navigationItem.rightBarButtonItems = [UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(pushAddViewController))]
    }
    
    @objc func pushAddViewController() {
        self.navigationController?.present(UINavigationController(rootViewController: GoalCreateViewController(title: i18n("new_goal"))), animated: true)
    }
    
    func pushShowViewController(index: Int, goal: Goal) {
        self.navigationController?.pushViewController(GoalShowViewController(goal: goal), animated: true)
    }
    
    func setupLayout() {
        setupNavigationBar()
        setupTableView()
    }
    
    func setupTableView() {
        let cellBuilder = { (el: Goal, cell: UITableViewCell) -> UITableViewCell in
            let goalCell = cell as! GoalCell
            
            return goalCell.with(goal: el)
        }
        
        tableView =
            LVFlatList(builder: cellBuilder)
                .with(cell: GoalCell.self)
                .with(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height))
                .with(refresh: fetchData)
                .with(selection: pushShowViewController)
        
        tableView.backgroundColor = UIColor(white: 0.9, alpha: 1)
        view.addSubview(tableView)
    }
    
}

