//
//  LVCell.swift
//  LaVie
//
//  Created by Bruno Barreira on 03/03/19.
//  Copyright © 2019 Bruno Barreira. All rights reserved.
//

import UIKit
import PinLayout
import FlexLayout

class LVCell: UITableViewCell {
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        backgroundColor = .clear
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupFlex() {
        contentView.flex.layout(mode: .adjustHeight)
    }
    
    override func setHighlighted(_ highlighted: Bool, animated: Bool) {
        if highlighted {
            contentView.alpha = 0.7
        } else {
            contentView.alpha = 1
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setupFlex()
    }
    
    override func sizeThatFits(_ size: CGSize) -> CGSize {
        contentView.pin.width(size.width)
        setupFlex()
        return contentView.frame.size
    }
}
