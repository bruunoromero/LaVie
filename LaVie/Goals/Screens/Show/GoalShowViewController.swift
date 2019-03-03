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

class GoalShowViewController: FormViewController, LVViewManager {
    var titleRow: TextRow!
    var dueDateRow: DateRow!
    var aspectsRow: PushRow<Aspect>!
    var objectivesSection: MultivaluedSection!
    var motivationsSection: MultivaluedSection!
    
    var goal: Goal?
    var goalDetails: GoalDetails?
    
    convenience init(goal: Goal) {
        self.init(title: goal.title)
        self.goal = goal
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchDetails()
        managerDidLoad()
        setupNavigationBar()
    }
    
    func fetchDetails() {
        GoalDetails.getCollection(from: goal!.id!).getDocuments { [unowned self] (snapshopt, error) in
            if let _ = error {
                print("ERROR")
            } else {
                self.goalDetails = GoalDetails(from: snapshopt!.documents.first!)
                self.setupForm()
            }
        }
    }
    
    func setupNavigationBar() {
        navigationItem.rightBarButtonItems = [UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(createGoal))]
    }
    
    @objc func createGoal() {
        let objectives = objectivesSection.values().compactMap { $0 as? String}
        let motivations = motivationsSection.values().compactMap { $0 as? String }
        
        guard let title = titleRow.value else {
            return
        }
        
        guard let aspect = aspectsRow.value else {
            return
        }
        
        guard let dueDate = dueDateRow.value else {
            return
        }
        
        var goalRef: DocumentReference? = nil
        let goal = Goal(title: title, aspect: aspect.name, dueDate: dueDate)
        
        goalRef = Goal.collection.addDocument(data: goal.toDocument(), completion: { [unowned self] error in
            if let err = error {
                print(err.localizedDescription)
            } else {
                let goalDetails = GoalDetails(objectives: objectives, motivations: motivations)
                GoalDetails.getCollection(from: goalRef!.documentID).addDocument(data: goalDetails.toDocument(), completion: { [unowned self] error in
                    if let err = error {
                        print(err.localizedDescription)
                    } else {
                        self.animatedDismiss()
                    }
                })
            }
        })
    }
    
    func setupForm() {
        setupObjectives()
        setupMotivations()
    }
    
    func setupObjectives() {
        objectivesSection = MultivaluedSection(multivaluedOptions: [.Insert, .Delete], header: i18n("objectives")) { section in
            section.addButtonProvider = { provider in
                return ButtonRow() { row in
                    row.title = i18n("new_objective")
                }
            }
            
            section.multivaluedRowToInsertAt = { provider in
                return TextRow() { row in
                    row.placeholder = i18n("objective")
                    row.add(rule: RuleRequired())
                }
            }
        }
        
        form +++ objectivesSection
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
}
