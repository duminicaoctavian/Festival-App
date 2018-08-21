//
//  Location.swift
//  Festival-App
//
//  Created by Duminica Octavian on 21/04/2018.
//  Copyright © 2018 Duminica Octavian. All rights reserved.
//

import Foundation
import SwiftyJSON

private struct SerializationKey {
    static let id = "_id"
    static let userID = "userID"
    static let latitude = "latitude"
    static let longitude = "longitude"
    static let title = "title"
    static let description = "description"
    static let address = "address"
    static let images = "images"
}

struct Location {
    public var id: String
    public var userID: String
    public var latitude: Double
    public var longitude: Double
    public var title: String
    public var address: String
    public var description: String
    public var price: Double
    public var images: [String]
    
    init() {
        self.id = ""
        self.userID = ""
        self.latitude = 0.0
        self.longitude = 0.0
        self.title = ""
        self.address = ""
        self.description = ""
        self.price = 0.0
        self.images = [String]()
    }
    
    init(id: String, userID: String, latitude: Double, longitude: Double, title: String, address: String,
         description: String, price: Double, images: [String]) {
        self.id = id
        self.userID = userID
        self.latitude = latitude
        self.longitude = longitude
        self.title = title
        self.address = address
        self.description = description
        self.price = price
        self.images = images
    }
    
    init(json: JSON) {
        self.id = json[SerializationKey.id].stringValue
        self.userID = json[SerializationKey.userID].stringValue
        self.latitude = json[SerializationKey.latitude].double ?? 0.0
        self.longitude = json[SerializationKey.longitude].double ?? 0.0
        self.title = json[SerializationKey.title].stringValue
        self.description = json[SerializationKey.description].stringValue
        self.address = json[SerializationKey.address].stringValue
        self.price = 25.0
        
        var images = [String]()
        let jsonArray = json[SerializationKey.images].arrayValue
        for item in jsonArray {
            let image = item.stringValue
            images.append(image)
        }
        self.images = images
    }
    
    init?(_ dataArray: [Any]) {
        guard let id = dataArray[0] as? String,
            let userID = dataArray[1] as? String,
            let latitude = dataArray[2] as? Double,
            let longitude = dataArray[3] as? Double,
            let title = dataArray[4] as? String,
            let address = dataArray[5] as? String,
            let description = dataArray[6] as? String,
            let images = dataArray[7] as? [String] else { return nil }
        
        self.id = id
        self.userID = userID
        self.latitude = latitude
        self.longitude = longitude
        self.title = title
        self.address = address
        self.description = description
        self.price = 25
        self.images = images
    }
}
