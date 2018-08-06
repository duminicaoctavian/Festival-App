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
        return ArtistService.instance.artists.count
    }
    
    func viewDidLoad() {
        loadArtists(forStage: .main)
    }
    
    func loadArtists(forStage stage: Stage) {
        ArtistService.instance.clearArtists()
        view?.reloadData()
        
        view?.startActivityIndicator()
        ArtistService.instance.getAllArtists(forStage: stage.rawValue) { [weak self] (success) in
            guard let weakSelf = self else { return }
            
            if success {
                weakSelf.view?.stopActivityIndicator()
                weakSelf.view?.reloadData()
            } else {
                // TODO
            }
        }
    }
    
    func viewWillDisappear() {
        ArtistService.instance.clearArtists()
        view?.reloadData()
    }
    
    func configure(_ itemView: ArtistItemView, at index: Int) {
        let artist = ArtistService.instance.artists[index]
        itemView.displayName(artist.name)
        itemView.displayArtistImage(artist.artistImageURL)
    }
    
    func handleDetailsTapped(forIndex index: Int, withPresenter presenter: ArtistDetailsPresenter) {
        let artist = ArtistService.instance.artists[index]
        presenter.nameChanged(artist.name)
        presenter.genreChanged(artist.genre)
        presenter.descriptionChanged(artist.description)
        presenter.imageURLChanged(artist.artistImageURL)
    }
    
}
