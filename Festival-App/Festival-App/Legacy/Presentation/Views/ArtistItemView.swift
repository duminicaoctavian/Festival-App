//
//  ArtistItemView.swift
//  Festival-App
//
//  Created by Octavian Duminica on 05/08/2018.
//  Copyright © 2018 Duminica Octavian. All rights reserved.
//

import Foundation

protocol ArtistItemView {
    func displayName(_ name: String)
    func displayArtistImage(_ URLString: String)
}
