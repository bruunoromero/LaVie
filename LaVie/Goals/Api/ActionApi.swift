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
        updateLocker.lock(id: action.id) {
            if let id = action.id {
                actionRef(id: id, from: goalId).updateData(action.toUpdateDocument()) { error in
                    print("HEY")
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
}
