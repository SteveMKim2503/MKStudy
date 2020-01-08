//
//  ViewMenu.swift
//  MKStudy
//
//  Created by Minkwan Kim on 2020/01/08.
//  Copyright © 2020 MK. All rights reserved.
//

import Foundation

struct ViewMenu {
    var name : String
    var price : Int
    var count : Int
    
    init(item: MenuItem) {
        self.name = item.name
        self.price = item.price
        self.count = 0
    }
    
    init(name: String, price: Int, count: Int = 0) {
        self.name = name
        self.price = price
        self.count = count
    }
    
    func countUp() -> ViewMenu {
        return ViewMenu(name: self.name, price: self.price, count: self.count + 1)
    }
    
    func countDown() -> ViewMenu {
        guard self.count > 0 else { return self }
        return ViewMenu(name: self.name, price: self.price, count: self.count - 1)
    }
    
    func asMenuItem() -> MenuItem {
        return MenuItem(name: self.name, price: self.price)
    }
}

extension ViewMenu: Equatable {
    
}
