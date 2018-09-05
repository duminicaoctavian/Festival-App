//
//  LocationDetailsView.swift
//  Festival-App
//
//  Created by Octavian Duminica on 21/08/2018.
//  Copyright © 2018 Duminica Octavian. All rights reserved.
//

import Foundation

protocol LocationDetailsView: class {
    func navigateToAccommodationScreen()
    func displayTitle(_ title: String)
    func displayAddress(_ address: String)
    func displayPrice(_ price: String)
    func displayDescription(_ description: String)
    func displayImage(_ imageURLString: String, at index: Int)
    func roundPriceView()
    func setupPageControl()
    func displayOffererName(_ username: String)
    func displayOferrerProfilePicture(_ URLString: String)
    func hideNavigationBar()
    func navigateToMyOffersScreen()
    func showCloseButton()
}
