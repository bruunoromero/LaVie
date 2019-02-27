//
//  LVViewController.swift
//  LaVie
//
//  Created by Bruno Barreira on 21/02/19.
//  Copyright © 2019 Bruno Barreira. All rights reserved.
//

import UIKit


class LVViewController: UIViewController, LVViewManager {
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    init(title: String) {
        super.init(nibName: nil, bundle: nil)
        initialize(title: title)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        managerDidLoad()
    }
}
