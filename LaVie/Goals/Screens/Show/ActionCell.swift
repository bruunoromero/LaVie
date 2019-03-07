//
//  ActionCell.swift
//  LaVie
//
//  Created by Bruno Barreira on 06/03/19.
//  Copyright © 2019 Bruno Barreira. All rights reserved.
//

import UIKit
import FlexLayout

class ActionCell: LVCell {
    var cardTitle: UILabel!
    var cardBackgroundView: UIView!
    
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
            self.setupCardTitle(flex)
        }
        
        cardBackgroundView.layer.cornerRadius = 4
    }
    
    func setupCardTitle(_ flex: Flex) {
        cardTitle = UILabel()
        
        flex.addItem(cardTitle)
    }
}

