//
//  Goal.swift
//  LaVie
//
//  Created by Bruno Barreira on 24/02/19.
//  Copyright © 2019 Bruno Barreira. All rights reserved.
//

import Firebase

struct Goal: Documentable {
    let id: String?
    var title: String
    var aspect: String
    var actions: [Action]
    var dueDate: Date
    let createdAt: Date
    
    init(id: String? = nil, title: String, aspect: String, actions: [Action], dueDate: Date) {
        self.id = id
        self.title = title
        self.aspect = aspect
        self.actions = actions
        self.dueDate = dueDate
        self.createdAt = Date()
    }
    
    init(from document: QueryDocumentSnapshot) {
        let acts: [Action] = (document["actions"] as! NSArray).map {
            let action = $0 as! NSDictionary
            return Action(from: action)
        }
        
        actions = acts
        id = document.documentID
        title = document["title"] as! String
        aspect = document["aspect"] as! String
        dueDate = (document["dueDate"] as! Timestamp).dateValue()
        createdAt = (document["createdAt"] as! Timestamp).dateValue()
    }
    
    static func getCollection(from: String) -> CollectionReference {
        return Firestore.firestore().collection("goals")
    }
    
    func toDocument() -> [String:Any] {
        return [
            "title": title,
            "aspect": aspect,
            "actions": actions.map { $0.toDocument() },
            "dueDate": Timestamp(date: dueDate),
            "createdAt": Timestamp(date: createdAt)
        ]
    }
}
