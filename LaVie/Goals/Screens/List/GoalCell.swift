//
//  GoalCell.swift
//  LaVie
//
//  Created by Bruno Barreira on 24/02/19.
//  Copyright © 2019 Bruno Barreira. All rights reserved.
//

import UIKit
import SnapKit
import PinLayout
import FlexLayout

class GoalCell: LVCell {
    var dueDate: UILabel!
    var cardTitle: UILabel!
    var cardIcon: UIImageView!
    var progressLabel: UILabel!
    var cardBackgroundView: UIView!
    var goalProgress: UIProgressView!
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupLayout() {
        contentView.flex.define { [unowned self] flex in
            self.setupCardBackground(flex)
        }
    }
    
    func setupCardBackground(_ flex: Flex) {
        cardBackgroundView = UIView()
        cardBackgroundView.backgroundColor = .white
        
        flex.addItem(cardBackgroundView).margin(8).padding(12).direction(.row).define { [unowned self] flex in
            self.setupCardIcon(flex)
            self.setupCardContent(flex)
        }
        
        cardBackgroundView.layer.cornerRadius = 4
    }
    
    func setupCardIcon(_ flex: Flex) {
        let divider = UIView()
        cardIcon = UIImageView()
        cardIcon.tintColor = .gray
        
        flex.addItem().height(100%).width(32).justifyContent(.center).define {
            $0.addItem(cardIcon).width(32).height(32)
        }
        
        flex.addItem().padding(12).height(100%).define {
            $0.addItem(divider).backgroundColor(.lightGray).height(100%).width(1)
        }
    }
    
    func setupCardContent(_ flex: Flex) {
        flex.addItem().direction(.column).grow(1).define { [unowned self] flex in
            flex.addItem().direction(.row).justifyContent(.spaceBetween).define { [unowned self] flex in
                self.setupCardTitle(flex)
                self.setupDueDate(flex)
            }
            self.setupProgress(flex)
        }
    }
    
    func setupCardTitle(_ flex: Flex) {
        cardTitle = UILabel()
       
        flex.addItem(cardTitle)
    }
    
    func setupDueDate(_ flex: Flex) {
        dueDate = UILabel()
        dueDate.fontSize = 14
        dueDate.textColor = .gray
        flex.addItem().addItem(dueDate)
    }
    
    func setupProgress(_ flex: Flex) {
        progressLabel = UILabel()
        goalProgress = UIProgressView()
        
        progressLabel.fontSize = 12
        progressLabel.textColor = .gray
        
        goalProgress.trackTintColor = .lightGray
        
        
        flex.addItem().direction(.column).marginTop(8).define {
            $0.addItem(goalProgress).width(80)
            $0.addItem(progressLabel).marginTop(4)
        }
    }
    
    func getProgress(objectives: [Objective]) -> Float {
        let total = Float(objectives.count)
        let totalDone = Float(objectives.filter { $0.isDone }.count)
        
        return totalDone / total
    }
    
    func with(goal: Goal) -> GoalCell {
        let progress = getProgress(objectives: goal.objectives)
        
        cardTitle.text = goal.title
        cardIcon.image = AspectManager.icon(from: goal.aspect)
        dueDate.text = goal.dueDate.short
        goalProgress.setProgress(progress, animated: true)
        progressLabel.text = "\(progress * 100)% \(i18n("completed"))"
        
        return self
    }
}
