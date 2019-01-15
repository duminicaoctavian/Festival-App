//
//  UMainViewController.swift
//  Festival-App
//
//  Created by Octavian Duminica on 15/01/2019.
//  Copyright © 2019 Duminica Octavian. All rights reserved.
//

import UIKit

class UMainViewController: UIViewController {
    
    lazy var presenter: UMainPresenter = {
        return UMainPresenter(view: self)
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension UMainViewController: UMainView {
    
}
