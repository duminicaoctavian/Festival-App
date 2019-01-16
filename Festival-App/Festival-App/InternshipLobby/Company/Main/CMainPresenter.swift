//
//  CMainPresenter.swift
//  Festival-App
//
//  Created by Octavian Duminica on 15/01/2019.
//  Copyright © 2019 Duminica Octavian. All rights reserved.
//

import Foundation

class CMainPresenter {
    weak var view: CMainView?
    
    init(view: CMainView) {
        self.view = view
    }
}
