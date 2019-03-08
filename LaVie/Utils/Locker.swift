//
//  Locker.swift
//  LaVie
//
//  Created by Bruno Romero on 07/03/19.
//  Copyright © 2019 Bruno Barreira. All rights reserved.
//

class Locker {
    var lockers: [String:Bool] = [:]
    
    func lock(_ id: String, block: () -> Void) {
        if lockers.index(forKey: id) == nil {
            lockers[id] = true
            block()
        }
    }
    
    func unlock(_ id: String) {
        if lockers.index(forKey: id) != nil {
            lockers.removeValue(forKey: id)
        }
    }
}
