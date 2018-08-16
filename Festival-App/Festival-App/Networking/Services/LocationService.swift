//
//  LocationService.swift
//  Festival-App
//
//  Created by Duminica Octavian on 21/04/2018.
//  Copyright © 2018 Duminica Octavian. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

private struct Constants {
    static let locationsSerializationKey = "locations"
}

class LocationService {
    
    static let shared = LocationService()
    var locations = [Location]()
    
    func getAllLocations(completion: @escaping CompletionHandler) {
        Alamofire.request(Route.locations, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: Header.bearerHeader).responseJSON { [weak self] (response) in
            
            guard let weakSelf = self else { return }
            
            if response.result.error == nil {
                guard let data = response.data else { completion(false); return }
                do {
                    let json = try JSON(data: data)
                    let array = json[Constants.locationsSerializationKey].arrayValue
                    for item in array {
                        let location = Location(json: item)
                        weakSelf.locations.append(location)
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
    
    func clearLocation() {
        locations.removeAll()
    }
}
