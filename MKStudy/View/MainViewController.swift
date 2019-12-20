//
//  MainViewController.swift
//  MKStudy
//
//  Created by MK on 2019/12/20.
//  Copyright © 2019 MK. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import ReactorKit

class MainViewController: UIViewController, StoryboardView {
    typealias Reactor = MainViewReactor
    var disposeBag = DisposeBag()
    
    
    // MARK: - View Life Cycle
    
    init(reactor: MainViewReactor = MainViewReactor()) {
        super.init(nibName: nil, bundle: nil)
        self.reactor = reactor
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.reactor = MainViewReactor()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    // MARK: - Reactor Binding
    
    func bind(reactor: MainViewReactor) {
        
        // view
        
        
        // action
        self.tableView.rx.itemSelected
            .map { Reactor.Action.selectMenu($0.row) }
            .bind(to: reactor.action)
            .disposed(by: self.disposeBag)
        
        // state
        reactor.state.map { $0.menus }
            .bind(to: self.tableView.rx.items(cellIdentifier: "cell")) { index,item,cell in
                
                cell.textLabel?.text = item.name
            }
            .disposed(by: self.disposeBag)
        
        reactor.state.map { $0.viewControllerTomove }
            .distinctUntilChanged()
            .filter { $0 != nil }
            .map { $0! }
            .subscribe(onNext: {
                self.navigationController?.pushViewController($0, animated: true)
            })
            .disposed(by: self.disposeBag)
    }
    


    // MARK: - InterfaceBuilder Links
    
    @IBOutlet weak var tableView: UITableView!
    
}
