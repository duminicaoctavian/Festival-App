//
//  AMainView.swift
//  Festival-App
//
//  Created by Octavian Duminica on 15/01/2019.
//  Copyright © 2019 Duminica Octavian. All rights reserved.
//

import Foundation

protocol AMainView: class {
    func navigateToDetails(at index: Int)
    func reloadData()
    func startActivityIndicator()
    func stopActivityIndicator()
    func displayAlert(title: String, message: String)
}
