//
//  TabController.swift
//  LaVie
//
//  Created by Bruno Barreira on 21/02/19.
//  Copyright © 2019 Bruno Barreira. All rights reserved.
//

import UIKit
import Material

class LVTabbableDelegate {
    static func initialize(controller: UIViewController, title: String, icon: UIImage?) {
        controller.tabBarItem = UITabBarItem(title: i18n(title), image: icon, selectedImage: nil)
    }
}

protocol LVTabbable: LVViewControllable {
    init(title: String, icon: UIImage?)
}

extension LVTabbable where Self:UIViewController {
    init(title: String, icon: UIImage?) {
        self.init(nibName: nil, bundle: nil)
        LVViewControllableDelegate.initialize(controller: self, title: title)
        LVTabbableDelegate.initialize(controller: self, title: title, icon: icon)
    }
}
