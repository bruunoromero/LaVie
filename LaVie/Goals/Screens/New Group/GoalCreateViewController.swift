//
//  GoalCreateViewController.swift
//  LaVie
//
//  Created by Bruno Barreira on 27/02/19.
//  Copyright © 2019 Bruno Barreira. All rights reserved.
//

import UIKit
import Eureka
import Firebase

class GoalCreateViewController: FormViewController, LVModable {
    var titleRow: TextRow!
    var dueDateRow: DateRow!
    var aspectsRow: PushRow<Aspect>!
    var actionsSection: MultivaluedSection!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        managerDidLoad()
        setupNavigationBar()
        setupLayout()
    }
    
    func setupNavigationBar() {
        navigationItem.rightBarButtonItems = [UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(createGoal))]
    }
    
    @objc func createGoal() {
        let actions = actionsSection.values().compactMap { $0 as? String }.map { Action(title: $0) }
        
        guard let title = titleRow.value else {
            return
        }
        
        guard let aspect = aspectsRow.value else {
            return
        }
        
        guard let dueDate = dueDateRow.value else {
            return
        }
        
        let goal = Goal(title: title, aspect: aspect.name, actions: actions, dueDate: dueDate)
        
        GoalApi.insert(goal: goal, onSucess: self.animatedDismiss)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
    }
    
    func setupLayout() {
        setupForm()
    }
    
    func setupForm() {
        setupTitleRow()
        setupActions()
        setupAspect()
        setupDueDate()
    }
    
    func setupTitleRow() {
        titleRow = TextRow() { row in
            row.title = i18n("what_is_your_goal")
            row.add(rule: RuleRequired())
            row.validationOptions = .validatesOnChange
        }
        
        form +++ Section(i18n("title")) <<< titleRow
    }
    
    func setupActions() {
        actionsSection = MultivaluedSection(multivaluedOptions: [.Insert, .Delete], header: i18n("actions")) { section in
            section.addButtonProvider = { provider in
                return ButtonRow() { row in
                    row.title = i18n("new_action")
                }
            }
            
            section.multivaluedRowToInsertAt = { provider in
                return TextRow() { row in
                    row.placeholder = i18n("action")
                    row.add(rule: RuleRequired())
                }
            }
        }
        
        form +++ actionsSection
    }
    
    func setupAspect() {
        aspectsRow = PushRow<Aspect>() { row in
            row.title = i18n("what_is_the_aspect_of_your_goal")
            row.options = [Aspect(name: "work"), Aspect(name: "health")]
        }

        form +++ Section(i18n("aspect")) <<< aspectsRow
    }
    
    func setupDueDate() {
        dueDateRow = DateRow() { row in
            let dateFormatter = DateFormatter()
            dateFormatter.locale = .current
            dateFormatter.dateStyle = .short
            
            row.dateFormatter = dateFormatter
            row.title = i18n("when_you_should_reach_your_goal")
            row.minimumDate = Date()
        }
        
        form +++ Section(i18n("due_date")) <<< dueDateRow
    }
}
