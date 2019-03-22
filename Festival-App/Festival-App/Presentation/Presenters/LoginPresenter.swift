//
//  LoginPresenter.swift
//  Festival-App
//
//  Created by Octavian Duminica on 20/07/2018.
//  Copyright © 2018 Duminica Octavian. All rights reserved.
//

import Foundation

private struct Constants {
    static let clientServer = "Client Server"
    static let serverless = "Serverless"
}

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
    
    func showSwitch() {
        if AuthService.shared.isServerless {
            view?.displaySwitch(value: true)
        } else {
            view?.displaySwitch(value: false)
        }
    }
    
    func handleLabelTitle() {
        if AuthService.shared.isServerless {
            view?.displayBackendLabel(Constants.serverless)
        } else {
            view?.displayBackendLabel(Constants.clientServer)
        }
    }
    
    func handleSwitch(forValue isOn: Bool) {
        if isOn {
            AuthService.shared.isServerless = true
            handleLabelTitle()
        } else {
            AuthService.shared.isServerless = false
            handleLabelTitle()
        }
    }
    
    func login() {
        guard let email = email, let password = password else { return }
        
        do {
            try Validator.validateEmail(email)
            try Validator.validatePassword(password)
        } catch {
            view?.presentLoginFailedFeedback(forError: error)
            return
        }
        
        if AuthService.shared.isServerless {
            FirebaseAuthService.shared.loginUser(email: email, password: password) { [weak self] (success) in
                guard let weakSelf = self else { return }
                weakSelf.view?.stopActivityIndicator()
                
                if success {
                    weakSelf.view?.navigateToHomeScreen()
                } else {
                    weakSelf.view?.presentLoginFailedFeedback(forError: nil)
                }
            }
        } else {
            AuthService.shared.loginUser(email: email, password: password) { [weak self] (success) in
                guard let weakSelf = self else { return }
                weakSelf.view?.stopActivityIndicator()
                
                if success {
                    weakSelf.view?.navigateToHomeScreen()
                } else {
                    weakSelf.view?.presentLoginFailedFeedback(forError: nil)
                }
            }
        }
    }
}
