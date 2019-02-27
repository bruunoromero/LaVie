//
//  GoalCell.swift
//  LaVie
//
//  Created by Bruno Barreira on 24/02/19.
//  Copyright © 2019 Bruno Barreira. All rights reserved.
//

import UIKit
import SnapKit

class GoalCell: UITableViewCell {
    var cardTitle: UILabel!
    var cardBackgroundView: UIView!
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        backgroundColor = .clear
        setupLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupLayout() {
        setupCardBackground()
        setupCardTitle()
    }
    
    func setupCardBackground() {
        cardBackgroundView = UIView()
        addSubview(cardBackgroundView)
        
        cardBackgroundView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(8)
        }
        
        cardBackgroundView.layer.cornerRadius = 4
        
    }
    
    override func setHighlighted(_ highlighted: Bool, animated: Bool) {
        if highlighted {
            cardBackgroundView.backgroundColor = .lightGray
        } else {
            cardBackgroundView.backgroundColor = .white
        }
    }
    
    func setupCardTitle() {
        cardTitle = UILabel()
        addSubview(cardTitle)
        
        cardTitle.snp.makeConstraints { make in
            make.edges.equalTo(cardBackgroundView).inset(16)
        }
        
    }
    
    func with(goal: Goal) -> GoalCell {
        cardTitle?.text = goal.title
        return self
    }
}
