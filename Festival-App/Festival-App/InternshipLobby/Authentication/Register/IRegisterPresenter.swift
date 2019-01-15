//
//  IRegisterPresenter.swift
//  Festival-App
//
//  Created by Octavian Duminica on 15/01/2019.
//  Copyright © 2019 Duminica Octavian. All rights reserved.
//

import Foundation

class IRegisterPresenter {
    weak var view: IRegisterView?
    
    init(view: IRegisterView) {
        self.view = view
    }
}
