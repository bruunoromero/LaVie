//
//  Date.swift
//  LaVie
//
//  Created by Bruno Barreira on 04/03/19.
//  Copyright © 2019 Bruno Barreira. All rights reserved.
//

import Foundation

extension Date {
    var short: String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = .current
        dateFormatter.dateStyle = .short
        
        return dateFormatter.string(from: self)
    }
}
