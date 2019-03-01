//
//  Aspect.swift
//  LaVie
//
//  Created by Bruno Barreira on 28/02/19.
//  Copyright © 2019 Bruno Barreira. All rights reserved.
//

struct Aspect: Equatable, CustomStringConvertible {
    var description: String { return i18n(self.name) }
    
    let name: String
}
