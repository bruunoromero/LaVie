//
//  ObjectiveSection.swift
//  LaVie
//
//  Created by Bruno Barreira on 06/03/19.
//  Copyright © 2019 Bruno Barreira. All rights reserved.
//

import UIKit
import RxDataSources

struct ActionSectionModel {
    var header: String
    var items: [Item]
}

extension ActionSectionModel: SectionModelType {
    typealias Item = Action
    
    init(original: ActionSectionModel, items: [Item]) {
        self = original
        self.items = items
    }
}
