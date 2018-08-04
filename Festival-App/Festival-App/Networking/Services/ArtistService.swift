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

class ArtistService {
    
    let artistsSerializationKey = "artists"
    
    static let instance = ArtistService()
    var artists = [Artist]()
    
    func findAllArtistsForStage(stage: String, completion: @escaping CompletionHandler) {
        Alamofire.request("\(URL_GET_ARTISTS)/\(stage)", method: .get, parameters: nil, encoding: JSONEncoding.default, headers: BEARER_HEADER).responseJSON { (response) in
            if response.result.error == nil {
                guard let data = response.data else { return }
                do {
                    let json = try JSON(data: data)
                    let array = json["artists"].arrayValue
                    for item in array {
                        let artist = Artist(json: item)
                        self.artists.append(artist)
                    }
                    completion(true)
                } catch {
                    debugPrint(error)
                }
            } else {
                completion(false)
                debugPrint(response.result.error as Any)
            }
        }
    }
    
    func getFilteredArtists(stage: String, day: Int, completion: @escaping CompletionHandler) {
        Alamofire.request("\(URL_GET_ARTISTS)/\(stage)/\(day)", method: .get, parameters: nil, encoding: JSONEncoding.default, headers: BEARER_HEADER).responseJSON { (response) in
        
            if response.result.error == nil {
                guard let data = response.data else { return }
                do {
                    let json = try JSON(data: data)
                    let array = json["artists"].arrayValue
                    for item in array {
                        let _id = item["_id"].stringValue
                        let name = item["name"].stringValue
                        let genre = item["genre"].stringValue
                        let description = item["description"].stringValue
                        let stageItem = item["stage"].stringValue
                        let day = item["day"].int
                        let date = item["date"].stringValue
                        let artistImageURL = item["artistImageURL"].stringValue
                        let artist = Artist(_id: _id, name: name, genre: genre, description: description, stage: stageItem, day: day, date: date, artistImageURL: artistImageURL, isOnUserTimeline: false)
                        self.artists.append(artist)
                    }
                    completion(true)
                } catch {
                    debugPrint(error)
                }
            } else {
                completion(false)
                debugPrint(response.result.error as Any)
            }
        }
    }
    
    func clearArtists() {
        artists.removeAll()
    }
}
