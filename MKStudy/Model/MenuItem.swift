//
//  MenuItem.swift
//  MKStudy
//
//  Created by Minkwan Kim on 2020/01/02.
//  Copyright © 2020 MK. All rights reserved.
//

import Foundation

struct MenuItem: Decodable {
    var name : String
    var price : Int
}

extension MenuItem: Equatable {
    static func == (lhs: MenuItem, rhs: MenuItem) -> Bool {
        return lhs.name == rhs.name && lhs.price == rhs.price
    }
}
