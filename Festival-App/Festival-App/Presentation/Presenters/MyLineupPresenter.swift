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
        ArtistService.shared.clearUserArtists()
        ArtistService.shared.clearArtists()
        view?.startActivityIndicator()
        
        ArtistService.shared.getAllArtists { [weak self] (success) in
            guard let weakSelf = self else { return }
            weakSelf.view?.stopActivityIndicator()
            
            if success {
                for artist in ArtistService.shared.artists {
                    let userArtistsIDs = AuthService.shared.user.artists
                    userArtistsIDs.forEach({ [weak self] (id) in
                        guard let weakSelf = self else { return }
                        if artist.id == id {
                            
                            let artists = ArtistService.shared.userArtists[artist.day - 1]
                            
                            if artists != nil {
                                guard var artists = artists else { return }
                                artists.append(artist)
                                ArtistService.shared.userArtists.updateValue(artists, forKey: artist.day - 1)
                                weakSelf.sortUserArtistsByDate(forDay: artist.day - 1)
                            } else {
                                let artistToAdd = [artist]
                                ArtistService.shared.userArtists[artist.day - 1] = artistToAdd
                            }
                        }
                    })
                }
                
                DispatchQueue.main.async { [weak self] in
                    guard let weakSelf = self else { return }
                    weakSelf.view?.reloadData()
                }
            } else {
                // TODO
            }
           
        }
    }
    
    private func sortUserArtistsByDate(forDay day: Int) {
        guard let artists = ArtistService.shared.userArtists[day] else { return }
        let sortedArray = artists.sorted { (artistOne, artistTwo) -> Bool in
            return artistOne.date < artistTwo.date
        }
        ArtistService.shared.userArtists[day] = sortedArray
    }
}
