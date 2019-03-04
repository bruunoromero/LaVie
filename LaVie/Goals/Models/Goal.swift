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
    let title: String
    let aspect: String
    let objectives: [Objective]
    let motivations: [String]
    let dueDate: Date
    let createdAt: Date
    
    init(id: String? = nil, title: String, aspect: String, objectives: [Objective], motivations: [String], dueDate: Date) {
        self.id = id
        self.title = title
        self.aspect = aspect
        self.objectives = objectives
        self.motivations = motivations
        self.dueDate = dueDate
        self.createdAt = Date()
    }
    
    init(from document: QueryDocumentSnapshot) {
        let objs: [Objective] = (document["objectives"] as! NSArray).map {
            let objective = $0 as! NSDictionary
            return Objective(from: objective)
        }
        
        objectives = objs
        id = document.documentID
        title = document["title"] as! String
        aspect = document["aspect"] as! String
        motivations = document["motivations"] as! [String]
        dueDate = (document["dueDate"] as! Timestamp).dateValue()
        createdAt = (document["createdAt"] as! Timestamp).dateValue()
    }
    
    static func getCollection(from: String) -> CollectionReference {
        return Firestore.firestore().collection("goals")
    }
    
    func toDocument() -> [String : Any] {
        return [
            "title": title,
            "aspect": aspect,
            "objectives": objectives.map { $0.toDocument() },
            "motivations": motivations,
            "dueDate": Timestamp(date: dueDate),
            "createdAt": Timestamp(date: createdAt)
        ]
    }
}
