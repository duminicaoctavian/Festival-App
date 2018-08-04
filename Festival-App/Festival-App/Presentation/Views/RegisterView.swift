//
//  RegisterView.swift
//  Festival-App
//
//  Created by Octavian Duminica on 04/08/2018.
//  Copyright © 2018 Duminica Octavian. All rights reserved.
//

import Foundation

protocol RegisterView: class {
    func startActivityIndicator()
    func stopActivityIndicator()
    func navigateToLoginScreen()
    func navigateToHomeScreen()
    func displayRegisterFailedAlert()
    func resetTextFields()
}
