//
//  LVViewManager.swift
//  LaVie
//
//  Created by Bruno Barreira on 27/02/19.
//  Copyright © 2019 Bruno Barreira. All rights reserved.
//

import UIKit


protocol LVViewManager {
    func initialize(title: String)
    func managerDidLoad()
}

extension LVViewManager where Self:UIViewController {
    func initialize(title: String) {
        self.title = title
    }
    
    func managerDidLoad() {
        self.view.backgroundColor = .white
        navigationController?.navigationBar.prefersLargeTitles = true
    }
}
