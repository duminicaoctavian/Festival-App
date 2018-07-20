//
//  LoginView.swift
//  Festival-App
//
//  Created by Octavian Duminica on 20/07/2018.
//  Copyright © 2018 Duminica Octavian. All rights reserved.
//

import Foundation

protocol LoginView: class {
    func displayLoginFailedAlert()
    func navigateToHomeScreen()
    func navigateToCreateAccountScreen()
    func roundLoginButton()
    func startActivityIndicator()
    func stopActivityIndicator()
}
