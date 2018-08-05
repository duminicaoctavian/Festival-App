//
//  ArtistsView.swift
//  Festival-App
//
//  Created by Octavian Duminica on 05/08/2018.
//  Copyright © 2018 Duminica Octavian. All rights reserved.
//

import Foundation

protocol ArtistsView: class {
    func startActivityIndicator()
    func stopActivityIndicator()
    func setupSlideMenu()
    func reloadData()
    func navigateToArtistDetailsScreen(fromIndex index: Int)
}
