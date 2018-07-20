//
//  LoginPresenter.swift
//  Festival-App
//
//  Created by Octavian Duminica on 20/07/2018.
//  Copyright © 2018 Duminica Octavian. All rights reserved.
//

import Foundation

class LoginPresenter {
    weak var view: LoginView?
    
    init(view: LoginView) {
        self.view = view
    }
}
