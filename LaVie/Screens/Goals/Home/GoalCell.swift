//
//  GoalCell.swift
//  LaVie
//
//  Created by Bruno Barreira on 24/02/19.
//  Copyright © 2019 Bruno Barreira. All rights reserved.
//

import UIKit
import SnapKit
import YogaKit

typealias Event = () -> Void

class GoalCell: UITableViewCell {
    var title: UILabel!
    var onPress: Event?
    var onPressEnded: Event?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupLayout()
        
        selectionStyle = .none
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupLayout() {
        setupContent()
        setupTitle()
    }
    
    func setupTitle() {
        title = UILabel()

        contentView.addSubview(title)
        
        title.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(12)
            make.left.equalToSuperview().inset(12)
            make.right.equalToSuperview().inset(12)
        }
    }
    
    func setupContent() {
        contentView.snp.makeConstraints { make in
            make.height.equalTo(128)
            make.edges.equalToSuperview().inset(8)
        }
        
        contentView.layer.cornerRadius = 4
        contentView.layer.shadowColor = UIColor.black.cgColor
        contentView.layer.shadowOpacity = 0.6
        contentView.layer.shadowRadius = 3
        contentView.layer.shadowOffset = CGSize(width: 0, height: 2)
        contentView.layer.borderWidth = 1
        contentView.layer.borderColor = UIColor.gray.cgColor
        contentView.backgroundColor = .white
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let pressed = onPress {
            pressed()
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let ended = onPressEnded {
            ended()
        }
    }
    
    func with(onPress: @escaping Event) -> GoalCell {
        self.onPress = onPress
        return self
    }
    
    func with(onPressEnded: @escaping Event) -> GoalCell {
        self.onPressEnded = onPressEnded
        return self
    }
    
    func with(goal: Goal) -> GoalCell {
        title.text = goal.title
        return self
    }
}
