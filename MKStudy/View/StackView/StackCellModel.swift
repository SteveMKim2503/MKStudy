//
//  StackCellModel.swift
//  MKStudy
//
//  Created by Minkwan Kim on 2019/12/21.
//  Copyright © 2019 MK. All rights reserved.
//

import Foundation

struct StackCellModel {
    var date   : String
    var number : String
    
    init() {
        func randomHexQuad() -> String {
            return NSString(format: "%X%X%X%X",
                            arc4random() % 16,
                            arc4random() % 16,
                            arc4random() % 16,
                            arc4random() % 16
                ) as String
        }
        
        self.date = DateFormatter.localizedString(from: Date(), dateStyle: .short, timeStyle: .none)
        self.number = "\(randomHexQuad())-\(randomHexQuad())-\(randomHexQuad())-\(randomHexQuad())"
    }
}

extension StackCellModel: Equatable {
    static func == (lhs: StackCellModel, rhs: StackCellModel) -> Bool {
        return lhs.date == rhs.date &&
            lhs.number == rhs.number
    }
    
}
