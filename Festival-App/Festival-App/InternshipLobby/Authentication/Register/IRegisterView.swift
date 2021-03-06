//
//  IRegisterView.swift
//  Festival-App
//
//  Created by Octavian Duminica on 15/01/2019.
//  Copyright © 2019 Duminica Octavian. All rights reserved.
//

import Foundation

protocol IRegisterView: class {
    func startActivityIndicator()
    func stopActivityIndicator()
    func navigateToApplicantScreen()
    func navigateToUniversityScreen()
    func navigateToCompanyScreen()
    func presentRegisterFailedFeedback(forError error: Error?)
}
