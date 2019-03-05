//
//  GoalViewController.swift
//  LaVie
//
//  Created by Bruno Barreira on 24/02/19.
//  Copyright © 2019 Bruno Barreira. All rights reserved.
//

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

    func deleteObjective(at index: Int) -> SwipeActionHandler {
        return { [unowned self] (action, row, completion) in
            self.goal.objectives.remove(at: index)
            self.objectivesSection.remove(at: index)
            completion?(true)

            if self.goal.objectives.count == 0 {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.6) {
                    self.form.remove(at: self.objectivesSection.index!)
                }
            }

        }
    }
    
    func deleteMotivation(at index: Int) -> SwipeActionHandler {
        return { [unowned self] (action, row, completion) in
            self.goal.motivations.remove(at: index)
            self.motivationsSection.remove(at: index)
            completion?(true)
            
            if self.goal.motivations.count == 0 {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.6) {
                    self.form.remove(at: self.motivationsSection.index!)
                }
            }
            
        }
    }

    func setupObjectives() {
        objectivesSection = SelectableSection<ListCheckRow<String>>(i18n("objectives"), selectionType: .multipleSelection)

        form +++ objectivesSection

        for index in goal.objectives.indices {
            let objective = goal.objectives[index]
            let row = ListCheckRow<String> { row in
                row.title = objective.title
                row.selectableValue = objective.title
                row.value = objective.isDone ? objective.title : nil
            }

            row.trailingSwipe.actions = [
                SwipeAction(
                        style: .destructive,
                        title: i18n("delete"),
                        handler: deleteObjective(at: index)
                )
            ]

            form.last! <<< row
        }
    }

    func setupMotivations() {
        motivationsSection = SelectableSection<ListCheckRow<String>>(i18n("motivations"), selectionType: .multipleSelection)

        form +++ motivationsSection

        for index in goal.motivations.indices {
            let motivation = goal.motivations[index]
            
            let row = ListCheckRow<String> { row in
                row.title = motivation
                row.value = nil
            }
            
            row.trailingSwipe.actions = [
                SwipeAction(
                    style: .destructive,
                    title: i18n("delete"),
                    handler: deleteMotivation(at: index)
                )
            ]
            
            form.last! <<< row
        }
    }
}
