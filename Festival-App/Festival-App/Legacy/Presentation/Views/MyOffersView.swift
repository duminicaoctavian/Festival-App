//
//  MyOffersView.swift
//  Festival-App
//
//  Created by Octavian Duminica on 05/09/2018.
//  Copyright © 2018 Duminica Octavian. All rights reserved.
//

import Foundation

protocol MyOfferView: class {
    func startActivityIndicator()
    func stopActivityIndicator()
    func navigateToOfferLocationDetailsScreen(from index: Int)
    func reloadData()
    func navigateToProfileScreen()
}
