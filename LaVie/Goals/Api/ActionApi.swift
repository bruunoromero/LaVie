//
//  ActionApi.swift
//  LaVie
//
//  Created by Bruno Barreira on 07/03/19.
//  Copyright © 2019 Bruno Barreira. All rights reserved.
//

import Firebase

fileprivate func actionRef(id actionId: String, from goalId: String) -> DocumentReference {
    return db.collection("goals").document(goalId).collection("actions").document(actionId)
}

fileprivate let updateLocker = Locker()

class ActionApi {
    static func update(action: Action, from goalId: String, onSuccess: @escaping () -> Void, onError: ErrorHandler? = nil) {
        guard let id = action.id else {
            return
        }
        
        updateLocker.lock(id) {
            actionRef(id: id, from: goalId).updateData(action.toUpdateDocument()) { error in
                if let err = error {
                    onError?(err)
                } else {
                    onSuccess()
                }
                
                updateLocker.unlock(id)
            }
        }
    }
}
