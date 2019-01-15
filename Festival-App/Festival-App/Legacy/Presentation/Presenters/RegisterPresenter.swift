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
    private var confirmPassword: String?
    
    func emailChanged(_ newValue: String?) {
        email = newValue
    }
    
    func usernameChanged(_ newValue: String?) {
        username = newValue
    }
    
    func passwordChanged(_ newValue: String?) {
        password = newValue
    }
    
    func confirmPasswordChanged(_ newValue: String?) {
        confirmPassword = newValue
    }
    
    func register() {
        guard let email = email, let username = username,
            let password = password, let confirmPassword = confirmPassword else { view?.presentRegisterFailedFeedback(forError: nil); return }
        
        do {
            try Validator.validateUsername(username)
            try Validator.validateEmail(email)
            try Validator.validatePasswordMatching(password: password, confirmPassword: confirmPassword)
        } catch {
            view?.presentRegisterFailedFeedback(forError: error)
            return
        }
        
        if AuthService.shared.isServerless {
            FirebaseAuthService.shared.registerUser(username: username, email: email, password: password) { [weak self] (success) in
                guard let weakSelf = self else { return }
                
                if success {
                    weakSelf.view?.stopActivityIndicator()
                    weakSelf.view?.navigateToHomeScreen()
                } else {
                    weakSelf.view?.presentRegisterFailedFeedback(forError: nil)
                }
            }
        } else {
//            AuthService.shared.registerUser(username: username, email: email, password: password, type: completion: { [weak self] (success) in
//                guard let weakSelf = self else { return }
//                
//                if (success) {
//                    weakSelf.view?.stopActivityIndicator()
//                    weakSelf.view?.navigateToHomeScreen()
//                } else {
//                    weakSelf.view?.presentRegisterFailedFeedback(forError: nil)
//                }
//            })
        }
    }
}
