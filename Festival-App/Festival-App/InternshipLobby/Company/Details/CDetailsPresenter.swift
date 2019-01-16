//
//  CDetailsPresenter.swift
//  Festival-App
//
//  Created by Octavian Duminica on 16/01/2019.
//  Copyright © 2019 Duminica Octavian. All rights reserved.
//

import Foundation

class CDetailsPresenter {
    weak var view: CDetailsView?
    
    init(view: CDetailsView) {
        self.view = view
    }
}
