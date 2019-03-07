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
    var numberOfActions: Int
    var numberOfDoneActions: Int
    let createdAt: Date
    
    var progress: Float {
        if numberOfActions == 0 || numberOfDoneActions == 0 {
            return 0
        }
        
        return (Float(numberOfDoneActions) / Float(numberOfActions)) * 100
    }
    
    init(id: String? = nil, title: String, aspect: String, actions: [Action], dueDate: Date) {
        self.id = id
        self.title = title
        self.aspect = aspect
        self.actions = actions
        self.dueDate = dueDate
        self.createdAt = Date()
        self.numberOfActions = actions.count
        self.numberOfDoneActions = actions.filter { $0.isDone }.count
    }
    
    init(from document: QueryDocumentSnapshot) {
        id = document.documentID
        title = document["title"] as! String
        aspect = document["aspect"] as! String
        dueDate = (document["dueDate"] as! Timestamp).dateValue()
        createdAt = (document["createdAt"] as! Timestamp).dateValue()
        numberOfActions = document["numberOfActions"] != nil ? document["numberOfActions"] as! Int : 0
        numberOfDoneActions = document["numberOfDoneActions"] != nil ? document["numberOfDoneActions"] as! Int : 0
    }
    
    func toCreateDocument() -> [String:Any] {
        return [
            "title": title,
            "aspect": aspect,
            "numberOfActions": 0,
            "numberOfDoneActions": 0,
            "dueDate": Timestamp(date: dueDate),
            "createdAt": Timestamp(date: createdAt),
        ]
    }
    
    func toUpdateDocument() -> [String : Any] {
        return [
            "title": title,
            "aspect": aspect,
            "dueDate": Timestamp(date: dueDate),
        ]
    }
}
