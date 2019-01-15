//
//  ArtistDetailsPresenter.swift
//  Festival-App
//
//  Created by Octavian Duminica on 05/08/2018.
//  Copyright © 2018 Duminica Octavian. All rights reserved.
//

import Foundation

class ArtistDetailsPresenter {
    weak var view: ArtistDetailsView?
    
    init(view: ArtistDetailsView) {
        self.view = view
    }
    
    private var name: String?
    private var genre: String?
    private var description: String?
    private var imageURL: String?
    
    func viewDidLoad() {
        presentDetails()
    }
    
    func nameChanged(_ newValue: String?) {
        name = newValue
    }
    
    func genreChanged(_ newValue: String?) {
        genre = newValue
    }
    
    func descriptionChanged(_ newValue: String?) {
        description = newValue
    }
    
    func imageURLChanged(_ newValue: String?) {
        imageURL = newValue
    }
    
    private func presentDetails() {
        guard let name = name, let genre = genre, let description = description, let imageURL = imageURL else { return }
        
        view?.displayArtistName(name)
        view?.displayGenre(genre)
        view?.displayArtistDescription(description)
        view?.displayArtistImage(imageURL)
    }
}
