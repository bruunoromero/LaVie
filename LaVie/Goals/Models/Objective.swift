//
//  Objective.swift
//  LaVie
//
//  Created by Bruno Barreira on 03/03/19.
//  Copyright © 2019 Bruno Barreira. All rights reserved.
//
import Firebase

struct Objective: Mappable {
    let title: String
    let isDone: Bool
    
    init(title: String, isDone: Bool = false) {
        self.title = title
        self.isDone = isDone
    }
    
    init(from dictionary: NSDictionary) {
        self.title = dictionary["title"] as! String
        self.isDone = dictionary["isDone"] as! Bool
    }
    
    func toDocument() -> [String : Any] {
        return [
            "title": self.title,
            "isDone": self.isDone
        ]
    }
}
