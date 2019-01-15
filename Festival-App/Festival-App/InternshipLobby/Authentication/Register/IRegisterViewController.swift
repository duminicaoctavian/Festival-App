//
//  IRegisterViewController.swift
//  Festival-App
//
//  Created by Octavian Duminica on 15/01/2019.
//  Copyright © 2019 Duminica Octavian. All rights reserved.
//

import UIKit

class IRegisterViewController: UIViewController {
    
    lazy var presenter: IRegisterPresenter = {
        return IRegisterPresenter(view: self)
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension IRegisterViewController: IRegisterView {
    
}
