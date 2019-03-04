//
//  LVPushManager.swift
//  LaVie
//
//  Created by Bruno Barreira on 03/03/19.
//  Copyright © 2019 Bruno Barreira. All rights reserved.
//

import UIKit

class LVPushDelegate {
    static func initialize(controller: UIViewController) {
        controller.hidesBottomBarWhenPushed = true
    }
}

protocol LVPushable: LVViewManager {
    init(title: String)
}

extension LVPushable where Self:UIViewController {
    init(title: String) {
        self.init(nibName: nil, bundle: nil)
        LVViewControllerManager.initialize(controller: self, title: title)
        LVPushDelegate.initialize(controller: self)
    }
}

