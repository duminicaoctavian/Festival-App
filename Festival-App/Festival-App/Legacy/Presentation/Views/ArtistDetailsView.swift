//
//  ArtistDetailsView.swift
//  Festival-App
//
//  Created by Octavian Duminica on 05/08/2018.
//  Copyright © 2018 Duminica Octavian. All rights reserved.
//

import Foundation

protocol ArtistDetailsView: class {
    func navigateToArtistsScreen()
    func displayArtistName(_ name: String)
    func displayGenre(_ genre: String)
    func displayArtistDescription(_ description: String)
    func displayArtistImage(_ imageURL: String)
}
