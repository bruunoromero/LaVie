//
//  GoalCell.swift
//  LaVie
//
//  Created by Bruno Barreira on 24/02/19.
//  Copyright © 2019 Bruno Barreira. All rights reserved.
//

import UIKit
import SnapKit
import YogaKit

typealias Event = () -> Void

class GoalCell: UITableViewCell {
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupLayout() {
        setupContent()
    }
    
    func setupContent() {
        contentView.backgroundColor = .white
    }
    
    func with(goal: Goal) -> GoalCell {
        textLabel?.text = goal.title
        return self
    }
}
