//
//  GoalApi.swift
//  LaVie
//
//  Created by Bruno Barreira on 05/03/19.
//  Copyright © 2019 Bruno Barreira. All rights reserved.
//

import Firebase

class GoalApi {
    static func getGoals(onSuccess: @escaping ([Goal]) -> Void, onError: ((Error) -> Void)? = nil) {
        Firestore.firestore().collection("goals").getDocuments { snapshot, error in
            if let error = error {
                onError?(error)
            } else {
                let data = snapshot!.documents.map { Goal(from: $0) }
                
                onSuccess(data)
            }
        }
    }
}
