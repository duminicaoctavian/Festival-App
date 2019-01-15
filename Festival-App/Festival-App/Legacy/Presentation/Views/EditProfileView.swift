//
//  EditProfileView.swift
//  Festival-App
//
//  Created by Octavian Duminica on 07/08/2018.
//  Copyright © 2018 Duminica Octavian. All rights reserved.
//

import Foundation

protocol EditProfileView: class {
    func navigateToProfileScreen()
    func displayImagePicker()
    func displayUsername(_ username: String)
    func displayProfileImage(_ URLString: String)
    func startActivityIndicator()
    func stopActivityIndicator()
}
