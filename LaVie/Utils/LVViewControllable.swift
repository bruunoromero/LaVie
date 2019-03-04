//
//  LVViewManager.swift
//  LaVie
//
//  Created by Bruno Barreira on 27/02/19.
//  Copyright © 2019 Bruno Barreira. All rights reserved.
//

import UIKit


class LVViewControllableDelegate {
    static func initialize(controller: UIViewController, title: String) {
        controller.title = title
    }
    
    static func managerDidLoad(controller: UIViewController) {
        controller.view.backgroundColor = .white
        controller.navigationController?.navigationBar.prefersLargeTitles = true
    }
}

protocol LVViewControllable {
    init(title: String)
    func managerDidLoad()
}

extension LVViewControllable where Self:UIViewController {
    init(title: String) {
        self.init(nibName: nil, bundle: nil)
        LVViewControllableDelegate.initialize(controller: self, title: title)
    }
    
    func managerDidLoad() {
        LVViewControllableDelegate.managerDidLoad(controller: self)
    }
}
