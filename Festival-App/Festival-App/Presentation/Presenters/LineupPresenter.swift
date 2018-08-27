//
//  LineupPresenter.swift
//  Festival-App
//
//  Created by Octavian Duminica on 24/08/2018.
//  Copyright © 2018 Duminica Octavian. All rights reserved.
//

import Foundation

class LineupPresenter {
    weak var view: LineupView?
    
    var selectedStage: Stage = .main
    var selectedDay: Int = 1
    
    var artistCount: Int {
        return ArtistService.shared.artists.count
    }
    
    init(view: LineupView) {
        self.view = view
    }
    
    func viewDidLoad() {
        getFilteredArtists(stage: selectedStage.rawValue, day: selectedDay)
    }
    
    func handleStageFilter(forSelection selection: Int) {
        switch selection {
        case 0:
            selectedStage = .main
        case 1:
            selectedStage = .resistance
        case 2:
            selectedStage = .live
        case 3:
            selectedStage = .oasis
        default:
            selectedStage = .main
        }
        getFilteredArtists(stage: selectedStage.rawValue, day: selectedDay)
    }
    
    func handleDayFilter(forSelection selection: Int) {
        selectedDay = selection
        getFilteredArtists(stage: selectedStage.rawValue, day: selectedDay)
    }
    
    func configure(_ itemView: LineupItemView, at index: Int) {
        let artist = ArtistService.shared.artists[index]
        guard let formattedDate = artist.date.convertFromISODate(toFormat: DateFormat.HHmm.rawValue) else { return }
        
        itemView.displayArtistName(artist.name)
        itemView.displayTimestamp(formattedDate)
        itemView.displayArtistImage(artist.artistImageURL)
        
        switch index {
        case 0:
            itemView.hideUpperTimeline()
            itemView.displayLowerTimeline()
        case ArtistService.shared.artists.count - 1:
            itemView.displayUpperTimeline()
            itemView.hideLowerTimeline()
        default:
            itemView.displayUpperTimeline()
            itemView.displayLowerTimeline()
        }
        
        if ArtistService.shared.artists.count == 1 {
            itemView.hideUpperTimeline()
            itemView.hideLowerTimeline()
        }
    }
    
    func addArtistToUserTimeline(withIndex index: Int) {
        let artist = ArtistService.shared.artists[index]
        
        if !artistAlreadyAdded(artistToAdd: artist, forDay: artist.day - 1) {
            let artists = ArtistService.shared.userArtists[artist.day - 1]
            
            if artists != nil {
                guard var artists = artists else { return }
                artists.append(artist)
                
                AuthService.shared.addArtistID(artist.id) { [weak self] (success) in
                    
                    guard let weakSelf = self else { return }
                    
                    if success {
                        ArtistService.shared.userArtists.updateValue(artists, forKey: artist.day - 1)
                        weakSelf.sortUserArtistsByDate(forDay: artist.day - 1)
                    } else {
                        // TODO
                    }
                }
            } else {
                let artistToAdd = [artist]
                
                AuthService.shared.addArtistID(artist.id) { [weak self] (success) in
                    
                    guard let _ = self else { return }
                    
                    if success {
                        ArtistService.shared.userArtists[artist.day - 1] = artistToAdd
                    } else {
                        // TODO
                    }
                }
            }
        }
    }
    
    private func artistAlreadyAdded(artistToAdd: Artist, forDay day: Int) -> Bool {
        let artists = ArtistService.shared.userArtists[day]
        
        if artists != nil {
            guard let artists = artists else { return false }
            
            if artists.contains(where: { [weak self] (artist) -> Bool in
                guard let _ = self else { return false }
                if artist.id == artistToAdd.id {
                    return true
                }
                return false
            }) {
                return true
            }
            return false
        } else {
            return false
        }
    }
    
    private func sortUserArtistsByDate(forDay day: Int) {
        guard let artists = ArtistService.shared.userArtists[day] else { return }
        let sortedArray = artists.sorted { [weak self] (artistOne, artistTwo) -> Bool in
            guard let _ = self else { return false }
            return artistOne.date < artistTwo.date
        }
        ArtistService.shared.userArtists[day] = sortedArray
    }
    
    private func getFilteredArtists(stage: String, day: Int) {
        ArtistService.shared.clearArtists()
        
        DispatchQueue.main.async { [weak self] in
            guard let weakSelf = self else { return }
            weakSelf.view?.startActivityIndicator()
            weakSelf.view?.reloadData()
        }
        
        ArtistService.shared.getFilteredArtists(forStage: stage, and: day) { [weak self] (success) in
            guard let _ = self else { return }
            
            if (success) {
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
