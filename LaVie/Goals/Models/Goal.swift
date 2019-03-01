//
//  Goal.swift
//  LaVie
//
//  Created by Bruno Barreira on 24/02/19.
//  Copyright © 2019 Bruno Barreira. All rights reserved.
//

import Firebase

struct Goal: Documentable {
    func toDocument() -> [String : Any] {
        return ["title": self.title, "aspect": self.aspect]
    }
    
    let id: String?
    let title: String
    let aspect: String
    
    init(id: String? = nil, title: String, aspect: String) {
        self.id = id
        self.title = title
        self.aspect = aspect
    }
    
    init(from document: QueryDocumentSnapshot) {
        id = document.documentID
        title = document["title"] as! String
        aspect = document["aspect"] as! String
    }
}
