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

class LocationService {
    static let instance = LocationService()
    
    var locations = [Location]()
    
    func findAllLocations(completion: @escaping CompletionHandler) {
        Alamofire.request("\(URL_GET_LOCATIONS)", method: .get, parameters: nil, encoding: JSONEncoding.default, headers: HEADER).responseJSON { (response) in
            
            if response.result.error == nil {
                guard let data = response.data else { return }
                do {
                    let json = try JSON(data: data)
                    let array = json["locations"].arrayValue
                    for item in array {
                        var images = [String]()
                        let _id = item["_id"].stringValue
                        let latitude = item["latitude"].stringValue
                        let longitude = item["longitude"].stringValue
                        let userId = item["userId"].stringValue
                        let title = item["title"].stringValue
                        let description = item["description"].stringValue
                        let address = item["address"].stringValue
                        let imageArray = item["images"].arrayValue
                        for i in imageArray {
                            let image = i.stringValue
                            images.append(image)
                        }
                        let location = Location(_id: _id, latitude: latitude, longitude: longitude, userId: userId, title: title, address: address, description: description, images: images)
                        self.locations.append(location)
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
    
    func clearLocation() {
        locations.removeAll()
    }
}
