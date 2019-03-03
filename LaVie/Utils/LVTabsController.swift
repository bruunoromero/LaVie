//
//  LVTabsController.swift
//  LaVie
//
//  Created by Bruno Barreira on 21/02/19.
//  Copyright © 2019 Bruno Barreira. All rights reserved.
//

import UIKit

class LVTabsController: UITabBarController {
    init(viewControllers: [UIViewController]) {
        super.init(nibName: nil, bundle: nil)
        self.tabBar.isTranslucent = false
        self.viewControllers = viewControllers
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
