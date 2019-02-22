//
//  LVTableViewController.swift
//  LaVie
//
//  Created by Bruno Barreira on 21/02/19.
//  Copyright © 2019 Bruno Barreira. All rights reserved.
//

import UIKit

class LVFlatList<T>: UITableView, UITableViewDataSource, UITableViewDelegate {
    var data: [T]?
    var identifier: String
    var builder: (T, UITableViewCell) -> UITableViewCell
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let el = data![indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath as IndexPath)
        return builder(el, cell)
    }
    
    init(data: [T], builder: @escaping (T, UITableViewCell) -> UITableViewCell) {
        self.data = data
        self.builder = builder
        self.identifier = "MyCell"
        
        super.init(frame: CGRect(x: 0, y: 0, width: 0, height: 0), style: .plain)
        
        self.register(UITableViewCell.self, forCellReuseIdentifier: identifier)
        self.delegate = self
        self.dataSource = self
    }
    
    convenience init(builder: @escaping (T, UITableViewCell) -> UITableViewCell) {
        self.init(data: [], builder: builder)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func update(data: [T]) {
        self.data = data
        DispatchQueue.main.async {
            self.reloadData()
        }
    }
    
    func with(data: [T]) -> LVFlatList {
        self.data = data
        return self
    }
    
    func with(extraCells: Bool) -> LVFlatList {
        self.tableFooterView = extraCells ? nil : UIView()
        return self
    }
    
    func with(cell: AnyClass) -> LVFlatList {
        self.register(cell, forCellReuseIdentifier: identifier)
        return self
    }
    
    func with(frame: CGRect) -> LVFlatList{
        self.frame = frame
        return self
    }
}
