//
//  Rxswiftin4hoursMenuTableViewCellReactor.swift
//  MKStudy
//
//  Created by Minkwan Kim on 2019/12/31.
//  Copyright © 2019 MK. All rights reserved.
//

import UIKit

import RxSwift
import ReactorKit

class Rxswiftin4hoursMenuTableViewCellReactor: Reactor {
    
    typealias Action = NoAction
    
    struct State {
        
    }

    var initialState: State
    
    init() {
        self.initialState = State()
    }

}
