//
//  ArtistsPresenter.swift
//  Festival-App
//
//  Created by Octavian Duminica on 05/08/2018.
//  Copyright © 2018 Duminica Octavian. All rights reserved.
//

import Foundation

class ArtistsPresenter {
    weak var view: ArtistsView?
    
    init(view: ArtistsView) {
        self.view = view
    }
    
    var artistsCount: Int {
        if AuthService.shared.isServerless {
            return FirebaseArtistService.shared.artists.count
        } else {
            return ArtistService.shared.artists.count
        }
    }
    
    func viewDidLoad() {
        loadArtists(forStage: .main)
    }
    
    func loadArtists(forStage stage: Stage) {
        ArtistService.shared.clearArtists()
        
        DispatchQueue.main.async { [weak self] in
            guard let weakSelf = self else { return }
            weakSelf.view?.reloadData()
        }
       
        view?.startActivityIndicator()
        
        if AuthService.shared.isServerless {
            
            FirebaseArtistService.shared.fetchArtistsFromDatabase { [weak self] (artists) in
                guard let weakSelf = self else { return }
                
                weakSelf.view?.stopActivityIndicator()
                DispatchQueue.main.async { [weak self] in
                    guard let weakSelf = self else { return }
                    FirebaseArtistService.shared.artists =  FirebaseArtistService.shared.artists.filter({ (artist) -> Bool in
                        return artist.stage == stage.rawValue ? true : false
                    })
                    weakSelf.view?.reloadData()
                }
            }
        } else {
            ArtistService.shared.getAllArtists(forStage: stage.rawValue) { [weak self] (success) in
                guard let weakSelf = self else { return }
                
                if success {
                    weakSelf.view?.stopActivityIndicator()
                    DispatchQueue.main.async { [weak self] in
                        guard let weakSelf = self else { return }
                        weakSelf.view?.reloadData()
                    }
                } else {
                    // TODO
                }
            }
        }
    }
    
    func viewWillDisappear() {
        ArtistService.shared.clearArtists()
        DispatchQueue.main.async { [weak self] in
            guard let weakSelf = self else { return }
            weakSelf.view?.reloadData()
        }
    }
    
    func configure(_ itemView: ArtistItemView, at index: Int) {
        if AuthService.shared.isServerless {
            let artist = FirebaseArtistService.shared.artists[index]
            itemView.displayName(artist.name)
            itemView.displayArtistImage(artist.artistImageURL)
        } else {
            let artist = ArtistService.shared.artists[index]
            itemView.displayName(artist.name)
            itemView.displayArtistImage(artist.artistImageURL)
        }
    }
    
    func handleDetailsTapped(forIndex index: Int, withPresenter presenter: ArtistDetailsPresenter) {
        if AuthService.shared.isServerless {
            let artist = FirebaseArtistService.shared.artists[index]
            presenter.nameChanged(artist.name)
            presenter.genreChanged(artist.genre)
            presenter.descriptionChanged(artist.description)
            presenter.imageURLChanged(artist.artistImageURL)
        } else {
            let artist = ArtistService.shared.artists[index]
            presenter.nameChanged(artist.name)
            presenter.genreChanged(artist.genre)
            presenter.descriptionChanged(artist.description)
            presenter.imageURLChanged(artist.artistImageURL)
        }
    }
}
