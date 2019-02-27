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

protocol LVModalViewManager: LVViewManager {
    func managerDidLoad()
}

extension LVModalViewManager where Self:UIViewController {
    func managerDidLoad() {
        view.backgroundColor = .white
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(animatedDismiss))
    }
}
