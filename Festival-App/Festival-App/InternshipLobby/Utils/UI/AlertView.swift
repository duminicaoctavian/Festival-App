//
//  AlertView.swift
//  Festival-App
//
//  Created by Octavian Duminica on 15/01/2019.
//  Copyright © 2019 Duminica Octavian. All rights reserved.
//

import Foundation

protocol AlertView: class {
    func displayAlert(title: String, message: String)
}
