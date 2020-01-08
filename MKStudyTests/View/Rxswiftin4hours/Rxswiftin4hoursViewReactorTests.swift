//
//  Rxswiftin4hoursViewReactorTests.swift
//  MKStudyTests
//
//  Created by Minkwan Kim on 2020/01/07.
//  Copyright © 2020 MK. All rights reserved.
//

import XCTest
import RxSwift
import RxCocoa
import ReactorKit
import RxTest
import RxBlocking

@testable import MKStudy

class Rxswiftin4hoursViewReactor: Reactor {
    
    enum Action {
        case fetchData
    }
    
    enum Mutation {
        case setMenus([MenuItem])
        case setIsLoading(Bool)
    }

    struct State {
        var menus: [MenuItem]?
        var isLoading: Bool
    }
    
    var menuService : MenuFetchable
    
    var initialState: State
    
    init(menuService: MenuFetchable) {
        self.menuService = menuService
        self.initialState = State(
            menus: nil,
            isLoading: false
        )
    }
    
    
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
            
            case .fetchData:
                return Observable.concat([
                    Observable.just(Mutation.setIsLoading(true)),
                    self.menuService.fetchMenus().map { Mutation.setMenus($0) },
                    Observable.just(Mutation.setIsLoading(false))
                ])
            
        }
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        switch mutation {
            
            case .setMenus(let menus):
                newState.menus = menus
            
            case .setIsLoading(let isLoading):
                newState.isLoading = isLoading
            
        }
        
        return newState
    }

}

class MockMenuStore: MenuFetchable {
    
    func fetchMenus() -> Observable<[MenuItem]> {
        Observable.create { observer -> Disposable in
            let menus = [
            MenuItem(name: "테스트1", price: 1),
            MenuItem(name: "테스트2", price: 10),
            MenuItem(name: "테스트3", price: 100),
            MenuItem(name: "테스트4", price: 1000)
            ]
            
            observer.onNext(menus)
            observer.onCompleted()
            
            return Disposables.create()
        }
    }
    
}

class Rxswiftin4hoursViewReactorTests: XCTestCase {

    
    func testFetchData() {
        let menuService = MockMenuStore()
        let reactor = Rxswiftin4hoursViewReactor(menuService: menuService)
        let disposeBag = DisposeBag()
        
        //
        XCTAssertNil(reactor.currentState.menus)
        reactor.action.onNext(.fetchData)
        reactor.state.map { $0.menus }
            .subscribe(onNext: {
                XCTAssertNotNil($0)
                XCTAssertEqual($0, [
                    MenuItem(name: "테스트1", price: 1),
                    MenuItem(name: "테스트2", price: 10),
                    MenuItem(name: "테스트3", price: 100),
                    MenuItem(name: "테스트4", price: 1000)
                ])
            })
            .disposed(by: disposeBag)
    }
    
    func testIsLoading() {
        // given
        let menuService = MockMenuStore()
        let reactor = Rxswiftin4hoursViewReactor(menuService: menuService)
        let disposeBag = DisposeBag()
        
        // when
        let scheduler = TestScheduler(initialClock: 0)
        let isLoading = scheduler.createObserver(Bool.self)

        reactor.state.map { $0.isLoading }
            .bind(to: isLoading)
            .disposed(by: disposeBag)
        
        scheduler.scheduleAt(10) {
            reactor.action.onNext(.fetchData)
        }

        scheduler.start()

        // then
        let expected = Recorded.events([
            .next(0, false),
            .next(10, true),
            .next(10, true),
            .next(10, false)
        ])
        
        XCTAssertEqual(isLoading.events, expected)
    }

}
