//
//  ViewController.swift
//  LaVie
//
//  Created by Bruno Barreira on 20/02/19.
//  Copyright © 2019 Bruno Barreira. All rights reserved.
//

import UIKit
import YogaKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addButton()
        setupNavigation()
        view.yoga.flexGrow = 1
        view.backgroundColor = .green
    }
    
    func setupNavigation() {
        navigationItem.titleLabel.text = "Home"
    }
    
    func addButton() {
        let contentView = UIView()
        contentView.backgroundColor = .red
        contentView.configureLayout { (layout) in
            layout.isEnabled = true
            layout.flexDirection = .row
            layout.width = 320
            layout.height = 80
            layout.marginTop = 40
            layout.marginLeft = 10
        }
        
        view.addSubview(contentView)
        contentView.yoga.applyLayout(preservingOrigin: true)
    }

}

