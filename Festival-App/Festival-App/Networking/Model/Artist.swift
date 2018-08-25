//
//  Artist.swift
//  Festival-App
//
//  Created by Duminica Octavian on 22/02/2018.
//  Copyright © 2018 Duminica Octavian. All rights reserved.
//

import Foundation
import SwiftyJSON

private struct SerializationKey {
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
    public private(set) var id: String
    public private(set) var name: String
    public private(set) var genre: String
    public private(set) var description: String
    public private(set) var stage: String
    public private(set) var day: Int
    public private(set) var date: String
    public private(set) var artistImageURL: String
    
    init(json: JSON) {
        self.id = json[SerializationKey.id].stringValue
        self.name = json[SerializationKey.name].stringValue
        self.genre = json[SerializationKey.genre].stringValue
        self.description = json[SerializationKey.description].stringValue
        self.stage = json[SerializationKey.stage].stringValue
        self.day = json[SerializationKey.day].int ?? 1
        self.date = json[SerializationKey.date].stringValue
        self.artistImageURL = json[SerializationKey.imageURL].stringValue
    }
}
