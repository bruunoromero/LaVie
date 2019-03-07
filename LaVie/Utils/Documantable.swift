//
//  Documantable.swift
//  LaVie
//
//  Created by Bruno Barreira on 28/02/19.
//  Copyright © 2019 Bruno Barreira. All rights reserved.
//

import Firebase

protocol Documentable {
    func toCreateDocument() -> [String:Any]
    func toUpdateDocument() -> [String:Any]
    init(from document: QueryDocumentSnapshot)
}
