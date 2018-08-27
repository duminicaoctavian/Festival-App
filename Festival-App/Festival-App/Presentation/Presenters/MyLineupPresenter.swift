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
    
    func artistsCount(forDay day: Int) -> Int? {
        return ArtistService.shared.userArtists[day]?.count
    }
    
    func viewDidLoad() {
        getUserArtists()
    }
    
    func configure(_ itemView: MyLineupItemView, at index: Int, with day: Int) {
        guard let artists = ArtistService.shared.userArtists[day] else { return }
        
        let artist = artists[index]
        guard let formattedDate = artist.date.convertFromISODate(toFormat: DateFormat.HHmm.rawValue) else { return }
        
        itemView.displayArtistName(artist.name)
        itemView.displayTimestampAndStage(formattedDate, and: artist.stage)
        itemView.displayArtistImage(artist.artistImageURL)
        
        guard let artistCount = ArtistService.shared.userArtists[day]?.count else { return }
        
        switch index {
        case 0:
            itemView.hideUpperTimeline()
            itemView.displayLowerTimeline()
        case artistCount - 1:
            itemView.displayUpperTimeline()
            itemView.hideLowerTimeline()
        default:
            itemView.displayUpperTimeline()
            itemView.displayLowerTimeline()
        }
        
        if artistCount == 1 {
            itemView.hideUpperTimeline()
            itemView.hideLowerTimeline()
        }
    }
    
    private func getUserArtists() {
        view?.startActivityIndicator()
        
        ArtistService.shared.getAllArtists { [weak self] (success) in
            guard let _ = self else { return }
            
            if success {
                DispatchQueue.main.async { [weak self] in
                    guard let weakSelf = self else { return }
                    weakSelf.view?.stopActivityIndicator()
                    weakSelf.view?.reloadData()
                }
            } else {
                // TODO
            }
           
        }
    }
}
