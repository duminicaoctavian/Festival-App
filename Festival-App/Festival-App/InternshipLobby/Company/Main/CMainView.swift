//
//  CMainView.swift
//  Festival-App
//
//  Created by Octavian Duminica on 15/01/2019.
//  Copyright © 2019 Duminica Octavian. All rights reserved.
//

import Foundation

protocol CMainView: class {
    func reloadData()
    func startActivityIndicator()
    func stopActivityIndicator()
    func displayAlert(title: String, message: String)
}
