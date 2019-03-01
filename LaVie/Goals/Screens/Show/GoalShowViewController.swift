//
//  GoalViewController.swift
//  LaVie
//
//  Created by Bruno Barreira on 24/02/19.
//  Copyright © 2019 Bruno Barreira. All rights reserved.
//

import UIKit

class GoalShowViewController: UIViewController, LVViewManager {
    convenience init(goal: Goal) {
        self.init(title: goal.title)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        managerDidLoad()
    }
}
