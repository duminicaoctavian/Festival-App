//
//  RegisterPresenter.swift
//  Festival-App
//
//  Created by Octavian Duminica on 04/08/2018.
//  Copyright © 2018 Duminica Octavian. All rights reserved.
//

import Foundation

class RegisterPresenter {
    weak var view: RegisterView?
    
    init(view: RegisterView) {
        self.view = view
    }
    
    private var email: String?
    private var username: String?
    private var password: String?
    
    func emailChanged(_ newValue: String?) {
        email = newValue
    }
    
    func usernameChanged(_ newValue: String?) {
        username = newValue
    }
    
    func passwordChanged(_ newValue: String?) {
        password = newValue
    }
    
    func register() {
        guard let email = email, let username = username, let password = password else { return }
        
        AuthService.instance.registerUser(username: username, email: email, password: password, completion: { [weak self] (success) in
            guard let weakSelf = self else { return }
            weakSelf.view?.stopActivityIndicator()
            
            if (success) {
                weakSelf.view?.navigateToHomeScreen()
            } else {
                weakSelf.view?.resetTextFields()
                weakSelf.view?.displayRegisterFailedAlert()
            }
        })
    }
}
