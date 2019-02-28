//
//  GoalCreateViewController.swift
//  LaVie
//
//  Created by Bruno Barreira on 27/02/19.
//  Copyright © 2019 Bruno Barreira. All rights reserved.
//

import UIKit
import Eureka

class GoalCreateViewController: FormViewController, LVModalViewManager {
    var dueDate: DateRow!
    var titleRow: TextRow!
    var aspects: PushRow<String>!
    var motivations: MultivaluedSection!
    
    convenience init(title: String) {
        self.init(nibName: nil, bundle: nil)
        initialize(title: title)
    }
    
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
            row.placeholder = "Qual a sua meta?"
            row.add(rule: RuleRequired())
            row.validationOptions = .validatesOnChange
        }
        
        form +++ Section("Título") <<< titleRow
    }
    
    func setupMotivations() {
        motivations = MultivaluedSection(multivaluedOptions: [.Insert, .Delete], header:"Motivações") { section in
            section.addButtonProvider = { provider in
                return ButtonRow() { row in
                    row.title = "Nova motivação"
                }
            }
            
            section.multivaluedRowToInsertAt = { provider in
                return TextRow() { row in
                    row.placeholder = "Motivação"
                    row.add(rule: RuleRequired())
                }
            }
        }
        
        form +++ motivations
    }
    
    func setupAspect() {
        aspects = PushRow<String>() { row in
            row.title = "Aspecto"
            row.options = ["Trabalho", "Saúde"]
        }

        form +++ Section("Aspecto") <<< aspects
    }
    
    func setupDueDate() {
        
        
        
        dueDate = DateRow() { row in
            let dateFormatter = DateFormatter()
            dateFormatter.locale = .current
            dateFormatter.dateStyle = .short
            
            row.dateFormatter = dateFormatter
            row.title = "Termina em"
            row.minimumDate = Date()
        }
        
        form +++ Section("Termina em") <<< dueDate
    }
}
