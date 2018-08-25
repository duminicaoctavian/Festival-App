//
//  MyLineupPresenter.swift
//  Festival-App
//
//  Created by Octavian Duminica on 24/08/2018.
//  Copyright © 2018 Duminica Octavian. All rights reserved.
//

import Foundation

class MyLineupPresenter {
    weak var view: MyLineupView?
    
    init(view: MyLineupView) {
        self.view = view
    }
    
    var userArtistsCount: Int {
        return ArtistService.shared.userArtists.count
    }
    
    func configure(_ itemView: MyLineupItemView, at index: Int) {
        let artist = ArtistService.shared.userArtists[index]
        guard let formattedDate = artist.date.convertFromISODate(toFormat: DateFormat.HHmm.rawValue) else { return }
        
        itemView.displayArtistName(artist.name)
        itemView.displayTimestampAndStage(formattedDate, and: artist.stage)
        itemView.displayArtistImage(artist.artistImageURL)
        
        switch index {
        case 0:
            itemView.hideUpperTimeline()
            itemView.displayLowerTimeline()
        case ArtistService.shared.userArtists.count - 1:
            itemView.displayUpperTimeline()
            itemView.hideLowerTimeline()
        default:
            itemView.displayUpperTimeline()
            itemView.displayLowerTimeline()
        }
        
        if ArtistService.shared.userArtists.count == 1 {
            itemView.hideUpperTimeline()
            itemView.hideLowerTimeline()
        }
    }
}
