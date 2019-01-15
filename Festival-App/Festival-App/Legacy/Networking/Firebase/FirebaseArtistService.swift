//
//  FirebaseArtistService.swift
//  Festival-App
//
//  Created by Octavian Duminica on 05/09/2018.
//  Copyright © 2018 Duminica Octavian. All rights reserved.
//

import Foundation
import FirebaseDatabase

class FirebaseArtistService {
    static let shared = FirebaseArtistService()
    
    var artists = [Artist]()
    
    func fetchArtistsFromDatabase(completion: @escaping CompletionHandler) {
        clearArtists()
        
        let artistsReference = Database.database().reference().child(FirebaseChild.artists)
        
        artistsReference.observeSingleEvent(of: .value) { [weak self] (snapshot) in
            guard let weakSelf = self else { completion(false); return }
            guard let array = snapshot.value as? NSArray else { completion(false); return }
            array.forEach({ (object) in
                if var dictionary = object as? [String: AnyObject] {
                    dictionary.updateValue(snapshot.key as AnyObject, forKey: "_id")
                    if let artist = Artist(dictionary: dictionary) {
                        weakSelf.artists.append(artist)
                    }
                }
            })
            completion(true)
        }
    }
    
    func clearArtists() {
        artists.removeAll()
    }
}
