//
//  Documantable.swift
//  LaVie
//
//  Created by Bruno Barreira on 28/02/19.
//  Copyright © 2019 Bruno Barreira. All rights reserved.
//

import Firebase

protocol Documentable {
    func toDocument() -> [String:Any]
    init(from: QueryDocumentSnapshot)
}
