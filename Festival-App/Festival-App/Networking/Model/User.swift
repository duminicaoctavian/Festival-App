//
//  User.swift
//  Festival-App
//
//  Created by Duminica Octavian on 22/04/2018.
//  Copyright © 2018 Duminica Octavian. All rights reserved.
//

import Foundation
import SwiftyJSON

private struct SerializationKey {
    static let id = "_id"
    static let username = "username"
    static let email = "email"
    static let imageURL = "imageURL"
    static let password = "password"
    static let artists = "artists"
    static let artistID = "artistID"
}

class User: NSObject {
    
    public private(set) var id: String
    public var username: String
    public private(set) var email: String
    public var imageURL: String
    public private(set) var artists: [String]
    
    init(json: JSON) {
        self.id = json[SerializationKey.id].stringValue
        self.username = json[SerializationKey.username].stringValue
        self.email = json[SerializationKey.email].stringValue
        self.imageURL = json[SerializationKey.imageURL].stringValue
        let jsonArray = json[SerializationKey.artists].arrayValue
        
        var artists = [String]()
        jsonArray.forEach { (json) in
            let artistID = json.stringValue
            artists.append(artistID)
        }
        
        self.artists = artists
    }
    
    init(id: String = "", username: String = "", email: String = "", imageURL: String = "", artists: [String] = [String]()) {
        self.id = id
        self.username = username
        self.email = email
        self.imageURL = imageURL
        self.artists = artists
    }
    
    static func generateBody(username: String, email: String, password: String) -> [String: String] {
        let body = [
            SerializationKey.username: username,
            SerializationKey.email: email,
            SerializationKey.password: password
        ]
        return body
    }
    
    static func generateBody(email: String, password: String) -> [String: String] {
        let body = [
            SerializationKey.email: email,
            SerializationKey.password: password
        ]
        return body
    }
    
    static func generateBody(username: String, password: String, imageURL: String) -> [String: String] {
        let body = [
            SerializationKey.username: username,
            SerializationKey.password: password,
            SerializationKey.imageURL: imageURL
        ]
        return body
    }
    
    static func generateBody(artistID: String) -> [String: String] {
        let body = [
            SerializationKey.artistID: artistID
        ]
        return body
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        guard let id = aDecoder.decodeObject(forKey: SerializationKey.id) as? String,
            let username = aDecoder.decodeObject(forKey: SerializationKey.username) as? String,
            let email = aDecoder.decodeObject(forKey: SerializationKey.email) as? String,
            let imageURL = aDecoder.decodeObject(forKey: SerializationKey.imageURL) as? String,
            let artists = aDecoder.decodeObject(forKey: SerializationKey.artists) as? [String] else { return nil }
        
        self.init(id: id, username: username, email: email, imageURL: imageURL, artists: artists)
    }
}

extension User: NSCoding {
    func encode(with aCoder: NSCoder) {
        aCoder.encode(id, forKey: SerializationKey.id)
        aCoder.encode(username, forKey: SerializationKey.username)
        aCoder.encode(email, forKey: SerializationKey.email)
        aCoder.encode(imageURL, forKey: SerializationKey.imageURL)
        aCoder.encode(artists, forKey: SerializationKey.artists)
    }
}
