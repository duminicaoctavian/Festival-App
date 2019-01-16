//
//  UDetailsViewController.swift
//  Festival-App
//
//  Created by Octavian Duminica on 16/01/2019.
//  Copyright © 2019 Duminica Octavian. All rights reserved.
//

import UIKit

class UDetailsViewController: UIViewController {
    
    lazy var presenter: UDetailsPresenter = {
        return UDetailsPresenter(view: self)
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension UDetailsViewController: UDetailsView {
    
}
