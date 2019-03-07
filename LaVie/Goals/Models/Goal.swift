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
    var actions: [Action]?
    var dueDate: Date
    var progress: Float
    let createdAt: Date
    
    init(id: String? = nil, title: String, aspect: String, actions: [Action], progress: Float, dueDate: Date) {
        self.id = id
        self.title = title
        self.aspect = aspect
        self.actions = actions
        self.dueDate = dueDate
        self.progress = progress
        self.createdAt = Date()
    }
    
    init(from document: QueryDocumentSnapshot) {
        id = document.documentID
        title = document["title"] as! String
        aspect = document["aspect"] as! String
        progress = document["progress"] as! Float
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
            "progress": progress,
            "dueDate": Timestamp(date: dueDate),
            "createdAt": Timestamp(date: createdAt)
        ]
    }
}
