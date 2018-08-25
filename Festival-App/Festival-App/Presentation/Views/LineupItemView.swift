//
//  LineupItemView.swift
//  Festival-App
//
//  Created by Octavian Duminica on 24/08/2018.
//  Copyright © 2018 Duminica Octavian. All rights reserved.
//

import Foundation

protocol LineupItemView {
    func displayArtistImage(_ URLString: String)
    func displayTimestamp(_ timestamp: String)
    func displayArtistName(_ name: String)
    func displayUpperTimeline()
    func displayLowerTimeline()
    func hideUpperTimeline()
    func hideLowerTimeline()
}

