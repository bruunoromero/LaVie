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
                    .with(onPress: {
                        UIView.animate(
                            withDuration: 0.3,
                            delay: 0,
                            usingSpringWithDamping: 0.5,
                            initialSpringVelocity: 5,
                            options: .curveEaseInOut,
                            animations: {
                                goalCell.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
                            },
                            completion: nil
                        )
                    })
                    .with(onPressEnded: {
                        UIView.animate(
                            withDuration: 0.3,
                            delay: 0,
                            usingSpringWithDamping: 0.5,
                            initialSpringVelocity: 5,
                            options: .curveEaseInOut,
                            animations: {
                                goalCell.transform = .identity
                            },
                            completion: nil
                        )
                        
//                        self.navigationController?.pushViewController(GoalViewController(goal: el), animated: true)
                    })
        }
        
        let tableView =
            LVFlatList(builder: cellBuilder)
                .with(data: data)
                .with(extraCells: false)
                .with(cell: GoalCell.self)
                .with(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height))

        view.addSubview(tableView)
        return tableView
    }
    
}

