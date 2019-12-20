//
//  StackViewViewController.swift
//  MKStudy
//
//  Created by MK on 2019/12/20.
//  Copyright © 2019 MK. All rights reserved.
//

import UIKit

class StackViewViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

}

extension StackViewViewController: initWithStoryboardDelegate {
    static func initWithStoryboard() -> UIViewController {
        return UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "StackViewViewController")
    }
}
