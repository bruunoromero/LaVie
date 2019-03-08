//
//  ActionCell.swift
//  LaVie
//
//  Created by Bruno Barreira on 06/03/19.
//  Copyright © 2019 Bruno Barreira. All rights reserved.
//

import UIKit
import Material
import FlexLayout

class ActionCell: LVCell {
    var isDone: Bool {
        didSet {
            cardRightIcon.image = getImage()
            cardTitle.textColor = getTitleColor()
        }
    }
    
    var cardTitle: UILabel!
    var cardRightIcon: UIImageView!
    var cardBackgroundView: UIView!
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        self.isDone = false
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
            self.setupRightIcon(flex)
        }
        
        cardBackgroundView.layer.cornerRadius = 4
    }
    
    func getImage() -> UIImage? {
        return isDone ? Icon.check : nil
    }
    
    func getTitleColor() -> UIColor {
        return isDone ? Color.gray : Color.black
    }
    
    func setupRightIcon(_ flex: Flex) {
        cardRightIcon = UIImageView(image: nil)
        
        flex.addItem(cardRightIcon).size(24)
    }
    
    func setupCardTitle(_ flex: Flex) {
        cardTitle = UILabel()
        
        flex.addItem(cardTitle).grow(1)
    }
}

