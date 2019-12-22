//
//  StackViewReactor.swift
//  MKStudy
//
//  Created by Minkwan Kim on 2019/12/21.
//  Copyright © 2019 MK. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import ReactorKit

class StackViewReactor: Reactor {
    
    enum Action {
        case addView
        case registerView(UIStackView)
        case deleteView(UIStackView)
    }
    
    enum Mutation {
        case setEntryInfo(stackCellModel?)
        case setCellToBeDeleted(UIStackView?)
    }
    
    struct State {
        var entryInfo : (date: String, number: String)?
        var cellToBeDeleted : UIStackView?
    }
    
    var stackViews : [UIStackView] = []
    
    var initialState: State
    
    init () {
        self.initialState = State(
            entryInfo: nil,
            cellToBeDeleted: nil
        )
    }
    
    func mutate(action: StackViewReactor.Action) -> Observable<StackViewReactor.Mutation> {
        switch action {
            
        case .addView:
            let cellModel = stackCellModel()
            return Observable.concat([
                Observable.just(Mutation.setEntryInfo(cellModel)),
                Observable.just(Mutation.setEntryInfo(nil)),
            ])

        case .registerView(let view):
            self.stackViews.append(view)
            return Observable.empty()
            
        case .deleteView(let view):
            self.stackViews = self.stackViews.filter { $0 != view }
            return Observable.concat([
                Observable.just(Mutation.setCellToBeDeleted(view)),
                Observable.just(Mutation.setCellToBeDeleted(nil)),
            ])
            
        }
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        switch mutation {
            
        case .setEntryInfo(let cellModel):
            newState.entryInfo = cellModel != nil ? (cellModel!.date, cellModel!.number) : nil
            
        case .setCellToBeDeleted(let view):
            newState.cellToBeDeleted = view
            
        }
        
        return newState
    }
}
