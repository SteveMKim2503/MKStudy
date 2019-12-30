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

class MainViewReactor: Reactor {
    
    enum Action {
        case selectMenu(Int)
    }
    
    enum Mutation {
        case setMenuToMove(UIViewController?)
    }
    
    struct State {
        var menus                : [MainMenuModel]
        var viewControllerTomove : UIViewController?
    }
    
    var initialState : State
    
    
    init() {
        let menus = [
            MainMenuModel(
                name           : "stackView",
                viewController : StackViewViewController.initWithStoryboard()
            ),
            MainMenuModel(
                name: "rxswiftin4hours_S2",
                viewController: Rxswiftin4hoursViewController.initWithStoryboard()
            )
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
