//
//  CDetailsViewController.swift
//  Festival-App
//
//  Created by Octavian Duminica on 16/01/2019.
//  Copyright © 2019 Duminica Octavian. All rights reserved.
//

import UIKit

class CDetailsViewController: UIViewController {
    
    lazy var presenter: CDetailsPresenter = {
        return CDetailsPresenter(view: self)
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension CDetailsViewController: CDetailsView {
    
}
