//
//  TabController.swift
//  LaVie
//
//  Created by Bruno Barreira on 21/02/19.
//  Copyright © 2019 Bruno Barreira. All rights reserved.
//

import UIKit
import Material

class LVTabControllerManager {
    static func initialize(controller: UIViewController, title: String, icon: UIImage?) {
        controller.tabBarItem = UITabBarItem(title: i18n(title), image: icon, selectedImage: nil)
    }
}

protocol LVTabManager: LVViewManager {
    init(title: String, icon: UIImage?)
}

extension LVTabManager where Self:UIViewController {
    init(title: String, icon: UIImage?) {
        self.init(nibName: nil, bundle: nil)
        LVViewControllerManager.initialize(controller: self, title: title)
        LVTabControllerManager.initialize(controller: self, title: title, icon: icon)
    }
}
