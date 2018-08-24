//
//  MyLineupPresenter.swift
//  Festival-App
//
//  Created by Octavian Duminica on 24/08/2018.
//  Copyright © 2018 Duminica Octavian. All rights reserved.
//

import Foundation

class MyLineupPresenter {
    weak var view: MyLineupView?
    
    init(view: MyLineupView) {
        self.view = view
    }
}
