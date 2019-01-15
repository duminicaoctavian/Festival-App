//
//  ILoginPresenter.swift
//  Festival-App
//
//  Created by Octavian Duminica on 15/01/2019.
//  Copyright © 2019 Duminica Octavian. All rights reserved.
//

import Foundation

class ILoginPresenter {
    weak var view: ILoginView?
    
    init(view: ILoginView) {
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
        
        do {
            try Validator.validateEmail(email)
            try Validator.validatePassword(password)
        } catch {
            view?.presentLoginFailedFeedback(forError: error)
            return
        }
        AuthService.shared.loginUser(email: email, password: password) { [weak self] (success) in
            guard let weakSelf = self else { return }
            weakSelf.view?.stopActivityIndicator()
            
            if (success) {
                weakSelf.handleNavigationToNextScreen()
            } else {
                weakSelf.view?.presentLoginFailedFeedback(forError: nil)
            }
        }
    }
    
    private func handleNavigationToNextScreen() {
        let user = AuthService.shared.user
        
        switch user.type {
        case "company":
            view?.navigateToCompanyScreen()
        case "university":
            view?.navigateToUniversityScreen()
        default:
            view?.navigateToApplicantScreen()
        }
    }
}
