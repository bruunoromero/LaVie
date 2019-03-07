//
//  LVViewModel.swift
//  LaVie
//
//  Created by Bruno Barreira on 06/03/19.
//  Copyright © 2019 Bruno Barreira. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class LVViewModel<T> {
    let data: BehaviorRelay<T>
    
    init(data: T) {
        self.data = BehaviorRelay(value: data)
    }
    
    func accept(event: T) {
        data.accept(event)
    }
}
