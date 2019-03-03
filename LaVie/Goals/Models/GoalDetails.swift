//
//  GoalDetails.swift
//  LaVie
//
//  Created by Bruno Barreira on 02/03/19.
//  Copyright © 2019 Bruno Barreira. All rights reserved.
//

import Firebase

struct GoalDetails: Documentable {
    let id: String?
    let objectives: [String]
    let motivations: [String]
    
    init(id: String? = nil, objectives: [String], motivations: [String]) {
        self.id = id
        self.objectives = objectives
        self.motivations = motivations
    }
    
    init(from document: QueryDocumentSnapshot) {
        id = document.documentID
        objectives = document["objectives"] as! [String]
        motivations = document["motivations"] as! [String]
    }
    
    static func getCollection(from: String) -> CollectionReference {
        return Goal.collection.document(from).collection("goalsDetails")
    }
    
    func toDocument() -> [String : Any] {
        return [
            "objectives": self.objectives,
            "motivations": self.motivations
        ]
    }
}
