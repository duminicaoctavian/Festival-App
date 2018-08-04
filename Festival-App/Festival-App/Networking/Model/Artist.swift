//
//  Artist.swift
//  Festival-App
//
//  Created by Duminica Octavian on 22/02/2018.
//  Copyright © 2018 Duminica Octavian. All rights reserved.
//

import Foundation
import SwiftyJSON

private struct ArtistSerializationKey {
    static let id = "_id"
    static let name = "name"
    static let genre = "genre"
    static let description = "description"
    static let stage = "stage"
    static let day = "day"
    static let date =  "date"
    static let imageURL = "artistImageURL"
}

struct Artist {
    public private(set) var _id: String
    public private(set) var name: String
    public private(set) var genre: String
    public private(set) var description: String
    public private(set) var stage: String
    public private(set) var day: String
    public private(set) var date: String
    public private(set) var artistImageURL: String
    public private(set) var isOnUserTimeline: Bool
    
    init(json: JSON) {
        self._id = json[ArtistSerializationKey.id].stringValue
        self.name = json[ArtistSerializationKey.name].stringValue
        self.genre = json[ArtistSerializationKey.genre].stringValue
        self.description = json[ArtistSerializationKey.description].stringValue
        self.stage = json[ArtistSerializationKey.stage].stringValue
        self.day = json[ArtistSerializationKey.day].stringValue
        self.date = json[ArtistSerializationKey.date].stringValue
        self.artistImageURL = json[ArtistSerializationKey.imageURL].stringValue
        self.isOnUserTimeline = false
    }
}
