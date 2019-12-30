//
//  Rxswiftin4hoursReceiptViewReactor.swift
//  MKStudy
//
//  Created by Minkwan Kim on 2019/12/30.
//  Copyright © 2019 MK. All rights reserved.
//


import UIKit

import RxSwift
import ReactorKit

class Rxswiftin4hoursReceiptViewReactor: Reactor {
    
    enum Action {
        
    }
    
    enum Mutation {
        
    }
    
    struct State {
        
    }
    
    var initialState : State
    
    init() {
        self.initialState = State()
    }
    
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
            
        }
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        switch mutation {
            
        }
        
        return newState
    }

}
