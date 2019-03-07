//
//  Objective.swift
//  LaVie
//
//  Created by Bruno Barreira on 03/03/19.
//  Copyright © 2019 Bruno Barreira. All rights reserved.
//
import Firebase

struct Action: Documentable {
    let id: String?
    var title: String
    var isDone: Bool
    
    init(id: String? = nil, title: String, isDone: Bool = false) {
        self.id = id
        self.title = title
        self.isDone = isDone
    }
    
    init(from document: QueryDocumentSnapshot) {
        self.id = document.documentID
        self.title = document["title"] as! String
        self.isDone = document["isDone"] as! Bool
    }
    
    func toDocument() -> [String : Any] {
        return [
            "title": self.title,
            "isDone": self.isDone
        ]
    }
}
