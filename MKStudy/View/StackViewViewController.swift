//
//  StackViewViewController.swift
//  MKStudy
//
//  Created by MK on 2019/12/20.
//  Copyright © 2019 MK. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import ReactorKit

class StackViewViewController: UIViewController, StoryboardView {
    typealias Reactor = StackViewReactor
    var disposeBag = DisposeBag()

    // MARK: - InterfaceBuilder Outlet
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var addViewButton: UIButton!
    
    
//    @IBAction func actionAddView(_ sender: Any) {
//        let stack = stackView
//        let index = stackView.arrangedSubviews.count - 1
//        let addView = stack?.arrangedSubviews[index]
//        let scroll = scrollView
//        let offset = CGPoint(x: scroll?.contentOffset.x ?? 0, y: (scroll?.contentOffset.y ?? 0) + (addView?.frame.size.height ?? 0))
//        let newView = createEntry()
//        newView.isHidden = true
//        stack?.insertArrangedSubview(newView, at: index)
//        UIView.animate(withDuration: 0.25) {
//            newView.isHidden = false
//            scroll?.contentOffset = offset
//        }
//    }
    
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let insets = UIEdgeInsets(top: 20.0, left: 0.0, bottom: 0.0, right: 0.0)
        scrollView.contentInset = insets
        scrollView.scrollIndicatorInsets = insets
    }
    
    
    // MARK: - Reactor
    
    func bind(reactor: StackViewReactor) {
        // view
        
        // action
        self.addViewButton.rx.tap
            .map { Reactor.Action.addView }
            .bind(to: reactor.action)
            .disposed(by: self.disposeBag)
        
        // state
        reactor.state.map { $0.entryInfo }
            .asDriver(onErrorJustReturn: nil)
            .filter { $0 != nil }
            .map { $0! }
            .drive(onNext: { [weak self] (date, number) in
                guard let `self` = self else { return }
                
                let entryInfo = self.createEntry(date: date, number: number)
                let newView = entryInfo.view
                entryInfo.deleteEvent
                    .observeOn(MainScheduler.asyncInstance)
                    .map { _ in Reactor.Action.deleteView(newView) }
                    .bind(to: reactor.action)
                    .disposed(by: self.disposeBag)
                
                let stack = self.stackView
                let index = self.stackView.arrangedSubviews.count - 1
                let addView = stack?.arrangedSubviews[index]
                let scroll = self.scrollView
                let offset = CGPoint(x: scroll?.contentOffset.x ?? 0, y: (scroll?.contentOffset.y ?? 0) + (addView?.frame.size.height ?? 0))
                
                newView.isHidden = true
                stack?.insertArrangedSubview(newView, at: index)
                UIView.animate(withDuration: 0.25) {
                    newView.isHidden = false
                    scroll?.contentOffset = offset
                }
                
                Observable.just(1)
                    .observeOn(MainScheduler.asyncInstance)
                    .map { _ in Reactor.Action.registerView(newView) }
                    .bind(to: reactor.action)
                    .disposed(by: self.disposeBag)
                
            })
            .disposed(by: self.disposeBag)
        
        reactor.state.map { $0.cellToBeDeleted }
            .distinctUntilChanged()
            .filter { $0 != nil }
            .map { $0! }
            .subscribe(onNext: { self.deleteStackView(view: $0) })
            .disposed(by: self.disposeBag)
    }
}

private extension StackViewViewController {
    
    func createEntry(date: String, number: String) -> (view: UIStackView, deleteEvent: ControlEvent<Void>) {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.alignment = .firstBaseline
        stack.distribution = .fill
        stack.spacing = 8
        let dateLabel = UILabel()
        dateLabel.text = date
        dateLabel.font = UIFont.preferredFont(forTextStyle: .body)
        let numberLabel = UILabel()
        numberLabel.text = number
        numberLabel.font = UIFont.preferredFont(forTextStyle: .headline)
        let deleteButton = UIButton(type: .roundedRect)
        deleteButton.setTitle("Delete", for: .normal)
        let deleteEvent = deleteButton.rx.tap
        deleteEvent.subscribe(onNext: { MKLog("stackView delete button tapped") })
            .disposed(by: self.disposeBag)
        
        stack.addArrangedSubview(dateLabel)
        stack.addArrangedSubview(numberLabel)
        stack.addArrangedSubview(deleteButton)
        
        return (stack, deleteEvent)
    }
    
    func deleteStackView(view: UIStackView) {
        UIView.animate(withDuration: 0.25, animations: {
            view.isHidden = true
        }) { (success) in
            view.removeFromSuperview()
        }
    }
    
}

extension StackViewViewController: initWithStoryboardDelegate {
    static func initWithStoryboard() -> UIViewController {
        let vc = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "StackViewViewController") as! StackViewViewController
        vc.reactor = StackViewReactor()
        return vc
    }
}

func MKLog(_ format: String, _ args: CVarArg...) {
    NSLog(String(format: "[MKLog](\(#file.components(separatedBy: "/").last ?? ""))(\(#line)) %@", format), args)
}
