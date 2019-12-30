//
//  Rxswiftin4hoursReceiptViewController.swift
//  MKStudy
//
//  Created by Minkwan Kim on 2019/12/30.
//  Copyright © 2019 MK. All rights reserved.
//

import UIKit

import RxSwift
import RxCocoa
import ReactorKit

class Rxswiftin4hoursReceiptViewController: UIViewController, StoryboardView {
    typealias Reactor = Rxswiftin4hoursReceiptViewReactor
    var disposeBag = DisposeBag()

    // MARK: - Interface Builder Outlet
    
    
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    
    // MARK: - Reactor
    
    func bind(reactor: Reactor) {
        
    }

}
