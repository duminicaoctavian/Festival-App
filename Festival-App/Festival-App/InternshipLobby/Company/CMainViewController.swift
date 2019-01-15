//
//  CMainViewController.swift
//  Festival-App
//
//  Created by Octavian Duminica on 15/01/2019.
//  Copyright © 2019 Duminica Octavian. All rights reserved.
//

import UIKit

class CMainViewController: UIViewController {
    
    lazy var presenter: CMainPresenter = {
        return CMainPresenter(view: self)
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension CMainViewController: CMainView {
    
}
