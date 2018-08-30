//
//  MyLineupView.swift
//  Festival-App
//
//  Created by Octavian Duminica on 24/08/2018.
//  Copyright © 2018 Duminica Octavian. All rights reserved.
//

import Foundation

protocol MyLineupView: class {
    func navigateToLineupScreen()
    func reloadData()
    func startActivityIndicator()
    func stopActivityIndicator()
}
