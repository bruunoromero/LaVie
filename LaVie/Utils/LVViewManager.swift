//
//  LVViewManager.swift
//  LaVie
//
//  Created by Bruno Barreira on 27/02/19.
//  Copyright © 2019 Bruno Barreira. All rights reserved.
//

import UIKit


class LVViewControllerManager {
    static func initialize(controller: UIViewController, title: String) {
        controller.title = title
        controller.hidesBottomBarWhenPushed = true
    }
    
    static func managerDidLoad(controller: UIViewController) {
        controller.view.backgroundColor = .white
        controller.navigationController?.navigationBar.prefersLargeTitles = true
    }
}

protocol LVViewManager {
    init(title: String)
    func managerDidLoad()
}

extension LVViewManager where Self:UIViewController {
    init(title: String) {
        self.init(nibName: nil, bundle: nil)
        LVViewControllerManager.initialize(controller: self, title: title)
    }
    
    func managerDidLoad() {
        LVViewControllerManager.managerDidLoad(controller: self)
    }
}
