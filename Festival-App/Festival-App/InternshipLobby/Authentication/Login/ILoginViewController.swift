//
//  ILoginViewController.swift
//  Festival-App
//
//  Created by Octavian Duminica on 15/01/2019.
//  Copyright © 2019 Duminica Octavian. All rights reserved.
//

import UIKit

class ILoginViewController: UIViewController {
    
    lazy var presenter: ILoginPresenter = {
        return ILoginPresenter(view: self)
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension ILoginViewController: ILoginView {
    
}
