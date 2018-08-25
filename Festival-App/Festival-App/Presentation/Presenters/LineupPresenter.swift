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
    
    var data = [Int: [(TimelinePoint, UIColor, String, String, String)]]()
    
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
    
    private func getFilteredArtists(stage: String, day: Int) {
        ArtistService.shared.clearArtists()
        data.removeAll()
        
        DispatchQueue.main.async { [weak self] in
            guard let weakSelf = self else { return }
            weakSelf.view?.startActivityIndicator()
            weakSelf.view?.reloadData()
        }
        
        ArtistService.shared.getFilteredArtists(forStage: stage, and: day) { [weak self] (success) in
            guard let weakSelf = self else { return }
            
            if (success) {
                for index in 0..<ArtistService.shared.artists.count {
                    let artist = ArtistService.shared.artists[index]
                    
                    if index == ArtistService.shared.artists.count - 1 {
                        weakSelf.data[Int(artist.day)]?.append((TimelinePoint(), backColor: UIColor.clear, artist.date, artist.name, artist.artistImageURL))
                        break
                    }
                    
                    let keyExists = weakSelf.data[Int(artist.day)] != nil
                    
                    if keyExists {
                        weakSelf.data[Int(artist.day)]?.append((TimelinePoint(), UIColor.lightGray, artist.date, artist.name, artist.artistImageURL))
                    } else {
                        weakSelf.data[Int(artist.day)] = [(TimelinePoint(), UIColor.lightGray, artist.date, artist.name, artist.artistImageURL)]
                    }
                    
                }
                
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
