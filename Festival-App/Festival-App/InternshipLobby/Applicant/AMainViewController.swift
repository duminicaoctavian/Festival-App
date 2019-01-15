//
//  AMainViewController.swift
//  Festival-App
//
//  Created by Octavian Duminica on 15/01/2019.
//  Copyright © 2019 Duminica Octavian. All rights reserved.
//

import UIKit

class AMainViewController: UIViewController {
    
    lazy var presenter: AMainPresenter = {
        return AMainPresenter(view: self)
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension AMainViewController: AMainView {
    
}
