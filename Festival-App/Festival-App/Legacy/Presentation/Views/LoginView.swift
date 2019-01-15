//
//  LoginView.swift
//  Festival-App
//
//  Created by Octavian Duminica on 20/07/2018.
//  Copyright © 2018 Duminica Octavian. All rights reserved.
//

import Foundation

protocol LoginView: class {
    func navigateToHomeScreen()
    func navigateToRegisterScreen()
    func startActivityIndicator()
    func stopActivityIndicator()
    func hideNavigationBar()
    func presentLoginFailedFeedback(forError error: Error?)
    func showBackendView()
    func hideBackendView()
    func displaySwitch(value: Bool)
    func displayBackendLabel(_ title: String)
    func roundBackendView()
}
