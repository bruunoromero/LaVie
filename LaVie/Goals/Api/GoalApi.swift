//
//  GoalApi.swift
//  LaVie
//
//  Created by Bruno Barreira on 05/03/19.
//  Copyright © 2019 Bruno Barreira. All rights reserved.
//

import Firebase

fileprivate let goalsRef = db.collection("goals")
fileprivate func goalsActionRef(from id: String) -> CollectionReference {
    return goalsRef.document(id).collection("actions")
}

class GoalApi {
    static func getGoals(onSuccess: @escaping ([Goal]) -> Void, onError: ErrorHandler? = nil) {
        goalsRef.getDocuments { snapshot, error in
            if let error = error {
                onError?(error)
            } else {
                let data = snapshot!.documents.map { Goal(from: $0) }
                
                onSuccess(data)
            }
        }
    }
    
    static func insert(goal: Goal, onSucess: @escaping () -> Void, onError: ErrorHandler? = nil) {
        var goalDocument = goal.toCreateDocument()
        
        goalDocument["progress"] = 0.0
        
        var goalRef: DocumentReference? = nil

        goalRef = goalsRef.addDocument(data: goalDocument) { error in
            if let err = error {
                onError?(err)
            } else {
                let batch = Firestore.firestore().batch()
                goal.actions?.forEach { action in
                    let ref = goalsActionRef(from: goalRef!.documentID).document()
                    batch.setData(action.toCreateDocument(), forDocument: ref)
                }
                
                batch.commit() { error in
                    if let err = error {
                        onError?(err)
                    } else {
                        onSucess()
                    }
                }
            }
        }
    }
    
    static func getActions(from id: String, onSucess: @escaping ([Action]) -> Void, onError: ErrorHandler? = nil) {
        goalsActionRef(from: id).getDocuments { snapshot, error in
            if let err = error {
                onError?(err)
            } else {
                let data = snapshot!.documents.map { Action(from: $0) }
                
                onSucess(data)
            }
        }
    }
}
