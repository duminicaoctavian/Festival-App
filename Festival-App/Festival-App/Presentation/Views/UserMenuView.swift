//
//  UserMenuView.swift
//  Festival-App
//
//  Created by Octavian Duminica on 05/08/2018.
//  Copyright © 2018 Duminica Octavian. All rights reserved.
//

import Foundation

protocol UserMenuView: class {
    func setupSlideMenu()
    func displayUserImage(_ URLString: String)
    func navigateToProfileScreen()
    func navigateToLoginScreen()
}
