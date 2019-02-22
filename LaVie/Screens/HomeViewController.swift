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
    var tableView: LVFlatList<String>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView = addTableView()
    }
    
    func addTableView() -> LVFlatList<String> {
        let cellBuilder = { (el: String, cell: UITableViewCell) -> UITableViewCell in
            cell.textLabel?.text = el
            return cell
        }
        
        let tableView =
            LVFlatList(builder: cellBuilder)
                .with(data: ["a"])
                .with(extraCells: false)
                .with(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height))
        
        view.addSubview(tableView)
        return tableView
    }
    
}

