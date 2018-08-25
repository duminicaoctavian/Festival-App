//
//  MyLineupItemView.swift
//  Festival-App
//
//  Created by Octavian Duminica on 25/08/2018.
//  Copyright © 2018 Duminica Octavian. All rights reserved.
//

import Foundation

protocol MyLineupItemView {
    func displayUpperTimeline()
    func displayLowerTimeline()
    func hideUpperTimeline()
    func hideLowerTimeline()
    func displayArtistImage(_ URLString: String)
    func displayTimestampAndStage(_ timestamp: String, and stage: String)
    func displayArtistName(_ name: String)
}
