//
//  AspectManager.swift
//  LaVie
//
//  Created by Bruno Barreira on 27/02/19.
//  Copyright © 2019 Bruno Barreira. All rights reserved.
//

import UIKit
import Material

fileprivate let mapping = ["work": Icon.work, "health": Icon.home]

class AspectManager {
    static func icon(from aspect: String) -> UIImage? {
        if let mapped = mapping[aspect.lowercased()] {
            return mapped
        } else {
            return nil
        }
    }
}
