//
//  GoalViewController.swift
//  LaVie
//
//  Created by Bruno Barreira on 24/02/19.
//  Copyright © 2019 Bruno Barreira. All rights reserved.
//

import UIKit


import UIKit
import Eureka
import Firebase

class GoalShowViewController: FormViewController, LVPushable {
    var goal: Goal!
    var titleRow: TextRow!
    var dueDateRow: DateRow!
    var aspectsRow: PushRow<Aspect>!
    var objectivesSection: SelectableSection<ListCheckRow<String>>!
    var motivationsSection: SelectableSection<ListCheckRow<String>>!
    
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
    
    func setupNavigationBar() {
        navigationItem.rightBarButtonItems = [UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(editGoal))]
    }
    
    @objc func editGoal() {
        
    }
    
    func setupForm() {
        setupObjectives()
        setupMotivations()
    }
    
    func setupObjectives() {
        objectivesSection = SelectableSection<ListCheckRow<String>>(i18n("objectives"), selectionType: .multipleSelection)
        
        form +++ objectivesSection
        
        goal.objectives.forEach { objective in
            form.last! <<< ListCheckRow<String> { row in
                row.title = objective.title
                row.selectableValue = objective.title
                row.value = nil
            }
        }
    }
    
    func setupMotivations() {
        motivationsSection = SelectableSection<ListCheckRow<String>>(i18n("motivations"), selectionType: .multipleSelection)
        
        form +++ motivationsSection
        
        goal.motivations.forEach { motivation in
            form.last! <<< ListCheckRow<String> { row in
                row.title = motivation
                row.value = nil
            }
        }
    }
}
