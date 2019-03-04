//
//  LVPushManager.swift
//  LaVie
//
//  Created by Bruno Barreira on 03/03/19.
//  Copyright © 2019 Bruno Barreira. All rights reserved.
//

import UIKit

class LVPushableDelegate {
    static func initialize(controller: UIViewController) {
        controller.hidesBottomBarWhenPushed = true
    }
}

protocol LVPushable: LVViewControllable {
    init(title: String)
}

extension LVPushable where Self:UIViewController {
    init(title: String) {
        self.init(nibName: nil, bundle: nil)
        LVViewControllableDelegate.initialize(controller: self, title: title)
        LVPushableDelegate.initialize(controller: self)
    }
}

