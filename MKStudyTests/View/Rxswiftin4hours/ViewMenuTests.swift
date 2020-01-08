//
//  ViewMenuTests.swift
//  MKStudyTests
//
//  Created by Minkwan Kim on 2020/01/08.
//  Copyright © 2020 MK. All rights reserved.
//

import XCTest
import RxSwift
import RxCocoa
import ReactorKit
import RxTest

@testable import MKStudy

class ViewMenuTests: XCTestCase {

    func testInit() {
        // given
        let menuItem = MenuItem(name: "test1", price: 1)
        let viewMenu = ViewMenu(item: menuItem)
        
        // then
        let expected = ViewMenu(name: "test1", price: 1, count: 0)
        XCTAssertEqual(viewMenu, expected)
    }
    
    func testCountUp() {
        // given
        let menuItem = MenuItem(name: "test1", price: 1)
        let viewMenu = ViewMenu(item: menuItem)
        
        // when
        let updatedViewMenu = viewMenu.countUp()
        
        // then
        let expected = ViewMenu(name: "test1", price: 1, count: 1)
        XCTAssertEqual(updatedViewMenu, expected)
    }

    func testCountDown() {
        // given
        let viewMenu = ViewMenu(name: "test1", price: 1, count: 1)
        
        // when
        let updatedViewMenu = viewMenu.countDown()
        
        // then
        let expected = ViewMenu(name: "test1", price: 1, count: 0)
        XCTAssertEqual(updatedViewMenu, expected)
    }
    
    func testCountDown2() {
        // given
        let viewMenu = ViewMenu(name: "test1", price: 1, count: 0)
        
        // when
        let updatedViewMenu = viewMenu.countDown()
        
        // then
        let expected = ViewMenu(name: "test1", price: 1, count: 0)
        XCTAssertEqual(updatedViewMenu, expected)
    }
    
    func testAsMenuItem() {
        // given
        let viewMenu = ViewMenu(name: "test1", price: 1, count: 0)
        
        // when
        let menuItem = viewMenu.asMenuItem()
        
        // then
        let expected = MenuItem(name: "test1", price: 1)
        XCTAssertEqual(menuItem, expected)
    }
}
