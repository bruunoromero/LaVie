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
    let objectives: [Objective]
    let motivations: [String]
    
    init(id: String? = nil, objectives: [Objective], motivations: [String]) {
        self.id = id
        self.objectives = objectives
        self.motivations = motivations
    }
    
    init(from document: QueryDocumentSnapshot) {
        let objs: [Objective] = (document["objectives"] as! NSArray).map {
            let objective = $0 as! NSDictionary
            return Objective(from: objective)
        }
        
        id = document.documentID
        objectives = objs
        motivations = document["motivations"] as! [String]
    }
    
    static func getCollection(from: String) -> CollectionReference {
        return Goal.collection.document(from).collection("goalsDetails")
    }
    
    func toDocument() -> [String : Any] {
        return [
            "motivations": self.motivations,
            "objectives": self.objectives.map { $0.toDocument() },
        ]
    }
}
