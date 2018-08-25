//
//  ArtistService.swift
//  Festival-App
//
//  Created by Duminica Octavian on 22/02/2018.
//  Copyright © 2018 Duminica Octavian. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

private struct Constants {
    static let artistsSerializationKey = "artists"
}

class ArtistService {
    
    static let shared = ArtistService()
    var artists = [Artist]()
    var userArtists = [Artist]()
    
    func getAllArtists(forStage stage: String, completion: @escaping CompletionHandler) {
        Alamofire.request("\(Route.artists)/\(stage)", method: .get, parameters: nil, encoding: JSONEncoding.default, headers: Header.bearerHeader).responseJSON { [weak self] (response) in
            
            guard let weakSelf = self else { completion(false); return }
            
            if response.result.error == nil {
                guard let data = response.data else { completion(false); return }
                do {
                    let json = try JSON(data: data)
                    let array = json[Constants.artistsSerializationKey].arrayValue
                    for item in array {
                        let artist = Artist(json: item)
                        weakSelf.artists.append(artist)
                    }
                    completion(true)
                } catch {
                    debugPrint(error)
                    completion(false)
                    return
                }
            } else {
                debugPrint(response.result.error as Any)
                completion(false)
                return
            }
        }
    }
    
    func getFilteredArtists(forStage stage: String, and day: Int, completion: @escaping CompletionHandler) {
        Alamofire.request("\(Route.artists)/\(stage)/\(day)", method: .get, parameters: nil, encoding: JSONEncoding.default, headers: Header.bearerHeader).responseJSON { [weak self] (response) in
        
            guard let weakSelf = self else { completion(false); return }
            
            if response.result.error == nil {
                guard let data = response.data else { completion(false); return }
                do {
                    let json = try JSON(data: data)
                    let array = json[Constants.artistsSerializationKey].arrayValue
                    for item in array {
                        let artist = Artist(json: item)
                        weakSelf.artists.append(artist)
                    }
                    completion(true)
                } catch {
                    debugPrint(error)
                    completion(false)
                    return
                }
            } else {
                debugPrint(response.result.error as Any)
                completion(false)
                return
            }
        }
    }
    
    func clearArtists() {
        artists.removeAll()
    }
}
