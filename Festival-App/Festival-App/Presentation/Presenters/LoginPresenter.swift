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
    
    private var email: String?
    private var password: String?
    
    func emailChanged(_ newValue: String?) {
        email = newValue
    }
    
    func passwordChanged(_ newValue: String?) {
        password = newValue
    }
    
    func login() {
        guard let email = email, let password = password else { return }
        
        AuthService.instance.loginUser(email: email, password: password) { [weak self] (success) in
            guard let weakSelf = self else { return }
            weakSelf.view?.stopActivityIndicator()
            
            if (success) {
                weakSelf.view?.navigateToHomeScreen()
            } else {
                weakSelf.view?.resetPasswordTextField()
                weakSelf.view?.displayLoginFailedAlert()
            }
        }
    }
}
