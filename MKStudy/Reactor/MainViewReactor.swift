//
//  MainViewReactor.swift
//  MKStudy
//
//  Created by MK on 2019/12/20.
//  Copyright © 2019 MK. All rights reserved.
//

import Foundation
import RxSwift
import ReactorKit

protocol initWithStoryboardDelegate {
    static func initWithStoryboard() -> UIViewController
}

struct MainMenuModel {
    var name           : String
    var viewController : UIViewController
}

let menuStringList : [String] = [
    "stackView"
]

class MainViewReactor: Reactor {
    
    enum Action {
        case selectMenu(Int)
    }
    
    enum Mutation {
        case setMenuToMove(UIViewController?)
    }
    
    struct State {
        var menus : [MainMenuModel]
        var viewControllerTomove : UIViewController?
    }
    
    var initialState : State
    
    
    init() {
        let vc = StackViewViewController.initWithStoryboard()
        let menus = [
            MainMenuModel(name: "stackView", viewController: vc)
        ]
        self.initialState = State(
            menus: menus
        )
    }
    
    func mutate(action: MainViewReactor.Action) -> Observable<MainViewReactor.Mutation> {
        switch action {
        
        case .selectMenu(let index):
            let vc = self.currentState.menus[index].viewController
            return Observable.concat([
                Observable.just(Mutation.setMenuToMove(vc)),
                Observable.just(Mutation.setMenuToMove(nil))
            ])
            
        }
    }
    
    func reduce(state: MainViewReactor.State, mutation: MainViewReactor.Mutation) -> MainViewReactor.State {
        var newState = state
        switch mutation {
            
        case .setMenuToMove(let vc):
            newState.viewControllerTomove = vc
            
        }
        
        return newState
    }
}
