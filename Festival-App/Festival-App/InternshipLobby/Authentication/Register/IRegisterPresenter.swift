//
//  IRegisterPresenter.swift
//  Festival-App
//
//  Created by Octavian Duminica on 15/01/2019.
//  Copyright © 2019 Duminica Octavian. All rights reserved.
//

import Foundation

private enum Role: Int {
    case applicant, company, university
    
    func name() -> String {
        switch self {
        case .applicant:
            return "applicant"
        case .company:
            return "company"
        case .university:
            return "university"
        }
    }
}

class IRegisterPresenter {
    weak var view: IRegisterView?
    
    init(view: IRegisterView) {
        self.view = view
    }
    
    private var email: String?
    private var username: String?
    private var password: String?
    private var confirmPassword: String?
    private var type: Role = .applicant
    
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
    
    func segmentedControlValueChanged(index: Int) {
        guard let role = Role(rawValue: index) else { return }
        
        switch role {
        case .applicant:
            type = .applicant
        case .company:
            type = .company
        case .university:
            type = .university
        }
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
        
        AuthService.shared.registerUser(username: username, email: email, password: password, type: type.name(), completion: { [weak self] (success) in
            guard let weakSelf = self else { return }
            
            if (success) {
                weakSelf.view?.stopActivityIndicator()
                weakSelf.handleNavigationToNextScreen()
            } else {
                weakSelf.view?.presentRegisterFailedFeedback(forError: nil)
            }
        })
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
