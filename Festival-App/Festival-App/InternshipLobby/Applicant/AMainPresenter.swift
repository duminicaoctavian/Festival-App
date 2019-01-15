//
//  AMainPresenter.swift
//  Festival-App
//
//  Created by Octavian Duminica on 15/01/2019.
//  Copyright © 2019 Duminica Octavian. All rights reserved.
//

import Foundation

class AMainPresenter {
    
    weak var view: AMainView?
    
    init(view: AMainView) {
        self.view = view
    }
}
