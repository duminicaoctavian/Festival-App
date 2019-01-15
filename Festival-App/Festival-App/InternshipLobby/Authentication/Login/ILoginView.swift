//
//  ILoginView.swift
//  Festival-App
//
//  Created by Octavian Duminica on 15/01/2019.
//  Copyright © 2019 Duminica Octavian. All rights reserved.
//

import Foundation

protocol ILoginView: class {
    func navigateToApplicantScreen()
    func navigateToUniversityScreen()
    func navigateToCompanyScreen()
    func navigateToRegisterScreen()
    func startActivityIndicator()
    func stopActivityIndicator()
    func presentLoginFailedFeedback(forError error: Error?)
}
