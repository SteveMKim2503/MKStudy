//
//  Rxswiftin4hoursViewController.swift
//  MKStudy
//
//  Created by Minkwan Kim on 2019/12/29.
//  Copyright © 2019 MK. All rights reserved.
//

import UIKit

import RxSwift
import RxCocoa
import ReactorKit

class Rxswiftin4hoursViewController: UIViewController, StoryboardView {
    typealias Reactor = Rxswiftin4hoursViewReactor
    var disposeBag = DisposeBag()
    
    
    // MARK: - Interface Builder Outlet
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var menuTableView: UITableView!
    
    @IBOutlet weak var clearButton: UIButton!
    @IBOutlet weak var itemCount: UILabel!
    
    @IBOutlet weak var totalPrice: UILabel!
    
    @IBOutlet weak var orderButton: UIButton!
    
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    // MARK: - Reactor

    func bind(reactor: Rxswiftin4hoursViewReactor) {
        
    }
    
}

extension Rxswiftin4hoursViewController: initWithStoryboardDelegate {

    static func initWithStoryboard() -> UIViewController {
        let vc = UIStoryboard.init(name: "Rxswiftin4hours", bundle: nil).instantiateViewController(withIdentifier: "Rxswiftin4hoursViewController") as! Rxswiftin4hoursViewController
        vc.reactor = Rxswiftin4hoursViewReactor()
        return vc
    }
    
}
