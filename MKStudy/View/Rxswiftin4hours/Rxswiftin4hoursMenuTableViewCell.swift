//
//  Rxswiftin4hoursMenuTableViewCell.swift
//  MKStudy
//
//  Created by Minkwan Kim on 2019/12/30.
//  Copyright © 2019 MK. All rights reserved.
//

import UIKit

import RxSwift
import RxCocoa
import ReactorKit

class Rxswiftin4hoursMenuTableViewCell: UITableViewCell, StoryboardView {
    typealias Reactor = Rxswiftin4hoursViewReactor
    var disposeBag = DisposeBag()

    // MARK: - Interface Builder Outlet
    
    @IBOutlet weak var plusButton: UIButton!
    @IBOutlet weak var minusButton: UIButton!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var count: UILabel!
    @IBOutlet weak var price: UILabel!
    
    
    // MARK: - View Life Cycle

    func bind(reactor: Reactor) {
        
    }
}
