//
//  GoalViewController.swift
//  LaVie
//
//  Created by Bruno Barreira on 24/02/19.
//  Copyright © 2019 Bruno Barreira. All rights reserved.
//

import UIKit

class GoalViewController: LVViewController {
    init(goal: Goal) {
        super.init(title: goal.title)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
