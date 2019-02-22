//
//  TabController.swift
//  LaVie
//
//  Created by Bruno Barreira on 21/02/19.
//  Copyright © 2019 Bruno Barreira. All rights reserved.
//

import UIKit
import Material

class LVTabController: LVViewController {
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        title = ""
        prepareTabItem(icon: nil)
    }
    
    init(title: String, icon: UIImage?) {
        super.init(title: title)
        self.title = title
        prepareTabItem(icon: icon)
    }
}

fileprivate extension LVTabController {
    func prepareTabItem(icon: UIImage?) {
        tabBarItem = UITabBarItem(title: title, image: icon, selectedImage: nil)
    }
}
