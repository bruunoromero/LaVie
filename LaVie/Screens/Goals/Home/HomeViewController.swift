//
//  ViewController.swift
//  LaVie
//
//  Created by Bruno Barreira on 20/02/19.
//  Copyright © 2019 Bruno Barreira. All rights reserved.
//

import UIKit
import YogaKit

class HomeViewController: LVTabController {
    var tableView: LVFlatList<Goal>!
    let data = [Goal(title: "Hello world!"), Goal(title: "Hello world!"), Goal(title: "Hello world!")]
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView = addTableView()
    }
    
    func addTableView() -> LVFlatList<Goal> {
        let cellBuilder = { (el: Goal, cell: UITableViewCell) -> UITableViewCell in
            let goalCell = cell as! GoalCell
            
            return goalCell
                    .with(goal: el)
        }
        
        let tableView =
            LVFlatList(builder: cellBuilder)
                .with(data: data)
                .with(extraCells: false)
                .with(cell: GoalCell.self)
                .with(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height))
                .with(selection: { goal in
                    self.navigationController?.pushViewController(GoalViewController(goal: goal), animated: true)
                })

        view.addSubview(tableView)
        return tableView
    }
    
}

