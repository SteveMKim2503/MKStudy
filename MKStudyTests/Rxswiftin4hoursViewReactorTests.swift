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
    
    func testIsLoading2() {
        // given
        let menuService = MockMenuStore()
        let reactor = Rxswiftin4hoursViewReactor(menuService: menuService)
        let disposeBag = DisposeBag()
        
        // when
        XCTAssertEqual(reactor.currentState.isLoading, false)
        reactor.action.onNext(.fetchData)
        
        let isloading = try! reactor.state.map { $0.isLoading }.toBlocking().first()!
        let isloading2 = try! reactor.state.map { $0.isLoading }.toBlocking(timeout: 20).last()!
        XCTAssertEqual(isloading, true)
        XCTAssertEqual(isloading2, false)
        
    }
    
    func testIsLoading() {
        let menuService = MockMenuStore()
        let reactor = Rxswiftin4hoursViewReactor(menuService: menuService)
        let disposeBag = DisposeBag()
        
        // given
        XCTAssertEqual(reactor.currentState.isLoading, false)
        
        let scheduler = TestScheduler(initialClock: 0)
//        let xs = scheduler.createHotObservable([
//            .next(0, reactor.state.map { $0.isLoading }.,
//            .next(10, ()),
//            .next(20, ()),
//            .completed(100)
//        ])
        
//        let isLoading = scheduler.createObserver(Bool.self)
//
//        reactor.state.map { $0.isLoading }
//            .debug()
//            .bind(to:
//                isLoading
//        )
//            .disposed(by: disposeBag)
        // when
        
//        reactor.action.onNext(.fetchData)
//
//        scheduler.start()
        
        let expected = Recorded.events([
            .next(0, false),
            .next(10, true),
            .next(20, false)
        ])
        
        
        SharingScheduler.mock(scheduler: scheduler) {
            let isLoading = scheduler.createObserver(Bool.self)
            reactor.state.map { $0.isLoading }
                .debug()
                .bind(to: isLoading)
                .disposed(by: disposeBag)
            scheduler.start()
            
            XCTAssertEqual(isLoading.events, expected)
        }
        
        
        
    }
    
    
    
//    override func setUp() {
//        // Put setup code here. This method is called before the invocation of each test method in the class.
//    }
//
//    override func tearDown() {
//        // Put teardown code here. This method is called after the invocation of each test method in the class.
//    }
//
//    func testExample() {
//        // This is an example of a functional test case.
//        // Use XCTAssert and related functions to verify your tests produce the correct results.
//    }
//
//    func testPerformanceExample() {
//        // This is an example of a performance test case.
//        self.measure {
//            // Put the code you want to measure the time of here.
//        }
//    }

}
