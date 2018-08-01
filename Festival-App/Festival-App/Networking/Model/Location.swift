//
//  Location.swift
//  Festival-App
//
//  Created by Duminica Octavian on 21/04/2018.
//  Copyright © 2018 Duminica Octavian. All rights reserved.
//

import Foundation

private struct LocationKey {
    static let latitude = "latitude"
    static let longitude = "longitude"
    static let userID = "userID"
    static let title = "title"
    static let address = "address"
    static let description = "description"
    static let images = "images"
}

struct Location {
    public var _id: String!
    public var latitude: Double!
    public var longitude: Double!
    public var userID: String!
    public var title: String!
    public var address: String!
    public var description: String!
    public var price: Int!
    public var images: [String]!
    
    var dictionaryRepresentation: [String: AnyObject] {
        return [
            LocationKey.latitude: latitude as AnyObject,
            LocationKey.longitude: longitude as AnyObject,
            LocationKey.userID: userID as AnyObject,
            LocationKey.title: title as AnyObject,
            LocationKey.address: address as AnyObject,
            LocationKey.description: description as AnyObject,
            LocationKey.images: images as AnyObject
        ]
    }
}
