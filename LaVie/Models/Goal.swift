//
//  Goal.swift
//  LaVie
//
//  Created by Bruno Barreira on 24/02/19.
//  Copyright © 2019 Bruno Barreira. All rights reserved.
//

import Firebase

struct Goal {
    let id: String?
    let title: String
    
    init(id: String? = nil, title: String) {
        self.id = id
        self.title = title
    }
    
    init(from document: QueryDocumentSnapshot) {
        id = document.documentID
        title = document["title"] as! String
    }
}
