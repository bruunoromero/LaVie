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

class GoalCreateViewController: FormViewController, LVModalViewManager {
    var titleRow: TextRow!
    var dueDateRow: DateRow!
    var aspectsRow: PushRow<Aspect>!
    var motivationsSection: MultivaluedSection!
    
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
        print("heyy")
        let motivations = motivationsSection.values().compactMap { $0 }
        
        guard let title = titleRow.value else {
            return
        }
        
        guard let aspect = aspectsRow.value else {
            return
        }
        
        guard let dueDate = dueDateRow.value else {
            return
        }
        
        let goal = Goal(title: title, aspect: aspect.name)
        
        Firestore.firestore().collection("goals").addDocument(data: goal.toDocument(), completion: { [unowned self] error in
            if let err = error {
                print("err")
            } else {
                self.animatedDismiss()
            }
        })
    }
    
    func setupLayout() {
        setupForm()
    }
    
    func setupForm() {
        setupTitleRow()
        setupMotivations()
        setupAspect()
        setupDueDate()
    }
    
    func setupTitleRow() {
        titleRow = TextRow() { row in
            row.placeholder = i18n("what_is_your_goal")
            row.add(rule: RuleRequired())
            row.validationOptions = .validatesOnChange
        }
        
        form +++ Section(i18n("title")) <<< titleRow
    }
    
    func setupMotivations() {
        motivationsSection = MultivaluedSection(multivaluedOptions: [.Insert, .Delete], header: i18n("motivations")) { section in
            section.addButtonProvider = { provider in
                return ButtonRow() { row in
                    row.title = i18n("new_motivation")
                }
            }
            
            section.multivaluedRowToInsertAt = { provider in
                return TextRow() { row in
                    row.placeholder = i18n("motivation")
                    row.add(rule: RuleRequired())
                }
            }
        }
        
        form +++ motivationsSection
    }
    
    func setupAspect() {
        let title = i18n("aspect")
        aspectsRow = PushRow<Aspect>() { row in
            row.title = title
            row.options = [Aspect(name: "work"), Aspect(name: "health")]
        }

        form +++ Section(title) <<< aspectsRow
    }
    
    func setupDueDate() {
        let title = i18n("due_date")
        
        dueDateRow = DateRow() { row in
            let dateFormatter = DateFormatter()
            dateFormatter.locale = .current
            dateFormatter.dateStyle = .short
            
            row.dateFormatter = dateFormatter
            row.title = title
            row.minimumDate = Date()
        }
        
        form +++ Section(title) <<< dueDateRow
    }
}
