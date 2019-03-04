//
//  LVModalViewController.swift
//  LaVie
//
//  Created by Bruno Barreira on 27/02/19.
//  Copyright © 2019 Bruno Barreira. All rights reserved.
//

import UIKit


extension UIViewController {
    @objc func animatedDismiss() {
        dismiss(animated: true, completion: nil)
    }
}


class LVModableDelegate {
    static func managerDidLoad(controller: UIViewController) {
        controller.navigationController?.navigationBar.prefersLargeTitles = false
        controller.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: controller, action: #selector(controller.animatedDismiss))
    }
}

protocol LVModable: LVViewControllable {
    func managerDidLoad()
}

extension LVModable where Self:UIViewController {
    func managerDidLoad() {
        LVViewControllableDelegate.managerDidLoad(controller: self)
        LVModableDelegate.managerDidLoad(controller: self)
    }
}
