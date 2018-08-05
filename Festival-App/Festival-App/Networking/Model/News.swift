//
//  News.swift
//  Festival-App
//
//  Created by Duminica Octavian on 26/03/2018.
//  Copyright © 2018 Duminica Octavian. All rights reserved.
//

import Foundation
import SwiftyJSON

private struct SerializationKey {
    static let id = "_id"
    static let title = "title"
    static let date = "date"
    static let description = "description"
    static let videoURL = "videoURL"
    static let imageURL = "imageURL"
}

struct News {
    public private(set) var id: String
    public private(set) var title: String
    public private(set) var date: String
    public private(set) var description: String
    public private(set) var videoURL: String?
    public private(set) var imageURL: String?
    
    init(json: JSON) {
        self.id = json[SerializationKey.id].stringValue
        self.title = json[SerializationKey.title].stringValue
        self.date = json[SerializationKey.date].stringValue
        self.description = json[SerializationKey.description].stringValue
        if let videoURL = json[SerializationKey.videoURL].string {
            self.videoURL = videoURL
        }
        if let imageURL = json[SerializationKey.imageURL].string {
            self.imageURL = imageURL
        }
    }
}
