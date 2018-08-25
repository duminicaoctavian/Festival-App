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
        let artistToAdd = ArtistService.shared.artists[index]
        if !artistAlreadyAdded(artistToAdd: artistToAdd) {
            ArtistService.shared.userArtists.append(artistToAdd)
            sortUserArtistsByDate()
            print(ArtistService.shared.userArtists.count)
        }
    }
    
    private func artistAlreadyAdded(artistToAdd: Artist) -> Bool {
        if ArtistService.shared.userArtists.contains(where: { [weak self] (artist) -> Bool in
            guard let _ = self else { return false }
            if artist.id == artistToAdd.id {
                return true
            }
            return false
        }) {
            return true
        }
        return false
    }
    
    private func sortUserArtistsByDate() {
        let sortedArray = ArtistService.shared.userArtists.sorted { [weak self] (artistOne, artistTwo) -> Bool in
            guard let _ = self else { return false }
            
            if artistOne.day != artistTwo.day {
                return artistOne.day < artistTwo.day
            } else {
                return artistOne.date < artistTwo.date
            }
        }
        ArtistService.shared.userArtists = sortedArray
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
