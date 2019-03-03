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
    init(from document: QueryDocumentSnapshot)
    static var collection: CollectionReference { get }
    static func getCollection(from: String) -> CollectionReference
}

extension Documentable  {
    static var collection: CollectionReference {
        return getCollection(from: "")
    }
}
