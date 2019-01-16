//
//  ADetailsView.swift
//  Festival-App
//
//  Created by Octavian Duminica on 16/01/2019.
//  Copyright © 2019 Duminica Octavian. All rights reserved.
//

import Foundation

protocol ADetailsView: class {
    func displayCompanyImage(_ URLString: String)
    func displayOfferTitle(_ text: String)
    func displayOfferDescription(_ text: String)
    func callNumber(_ text: String)
    func openFilePicker()
    func displayAlert(title: String, message: String)
    func startActivityIndicator()
    func stopActivityIndicator()
}
