//
//  ProfileView.swift
//  Festival-App
//
//  Created by Octavian Duminica on 07/08/2018.
//  Copyright © 2018 Duminica Octavian. All rights reserved.
//

import Foundation

protocol ProfileView: class {
    func hideNavigationBar()
    func setupSlideMenu()
    func displayUsername(_ username: String)
    func displayProfileImage(_ URLString: String)
    func navigateToEditProfileScreen()
    func navigateToOrderHistoryScreen()
    func navigateToMyOffersScreen()
}
