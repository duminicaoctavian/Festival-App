//
//  OfferService.swift
//  Festival-App
//
//  Created by Octavian Duminica on 16/01/2019.
//  Copyright © 2019 Duminica Octavian. All rights reserved.
//

import Foundation

import Foundation
import Alamofire
import SwiftyJSON

private struct Constants {
    static let offersSerializationKey = "offers"
}

class OfferService {
    
    static let shared = OfferService()
    var offers = [Offer]()
    
    func getAllOffers(completion: @escaping CompletionHandler) {
        Alamofire.request(Route.offers, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: Header.bearerHeader).responseJSON { [weak self] (response) in
            
            guard let weakSelf = self else { completion(false); return }
            
            if response.result.error == nil {
                guard let data = response.data else { completion(false); return }
                do {
                    let json = try JSON(data: data)
                    let array = json[Constants.offersSerializationKey].arrayValue
                    
                    for item in array {
                        let offer = Offer(json: item)
                        weakSelf.offers.append(offer)
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
    
//    func getAllArtists(forStage stage: String, completion: @escaping CompletionHandler) {
//        Alamofire.request("\(Route.artists)/\(stage)", method: .get, parameters: nil, encoding: JSONEncoding.default, headers: Header.bearerHeader).responseJSON { [weak self] (response) in
//
//            guard let weakSelf = self else { completion(false); return }
//
//            if response.result.error == nil {
//                guard let data = response.data else { completion(false); return }
//                do {
//                    let json = try JSON(data: data)
//                    let array = json[Constants.artistsSerializationKey].arrayValue
//                    for item in array {
//                        let artist = Artist(json: item)
//                        weakSelf.artists.append(artist)
//                    }
//                    completion(true)
//                } catch {
//                    debugPrint(error)
//                    completion(false)
//                    return
//                }
//            } else {
//                debugPrint(response.result.error as Any)
//                completion(false)
//                return
//            }
//        }
//    }
    
    func clearOffers() {
        offers.removeAll()
    }
}
