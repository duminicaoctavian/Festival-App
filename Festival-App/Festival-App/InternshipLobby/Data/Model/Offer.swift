//
//  Offer.swift
//  Festival-App
//
//  Created by Octavian Duminica on 16/01/2019.
//  Copyright © 2019 Duminica Octavian. All rights reserved.
//

import Foundation
import SwiftyJSON

private struct SerializationKey {
    static let id = "_id"
    static let userID = "userID"
    static let title = "title"
    static let description = "description"
    static let phone = "phone"
    static let companyImageURL = "companyImageURL"
    static let datePosted = "datePosted"
}

struct Offer {
    public var id: String
    public var userID: String
    public var title: String
    public var description: String
    public var phone: String
    public var companyImageURL: String
    public var datePosted: String
    
    init(id: String, userID: String, title: String, description: String, phone: String, companyImageURL: String, datePosted: String) {
        self.id = id
        self.userID = userID
        self.title = title
        self.description = description
        self.phone = phone
        self.companyImageURL = companyImageURL
        self.datePosted = datePosted
    }
    
    init(json: JSON) {
        self.id = json[SerializationKey.id].stringValue
        self.userID = json[SerializationKey.userID].stringValue
        self.title = json[SerializationKey.title].stringValue
        self.description = json[SerializationKey.description].stringValue
        self.phone = json[SerializationKey.phone].stringValue
        self.companyImageURL = json[SerializationKey.companyImageURL].stringValue
        self.datePosted = json[SerializationKey.datePosted].stringValue
    }
}

