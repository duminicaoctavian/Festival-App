//
//  Message.swift
//  Festival-App
//
//  Created by Octavian on 07/01/2018.
//  Copyright © 2018 Octavian. All rights reserved.
//

import Foundation
import SwiftyJSON

private struct SerializationKey {
    static let id = "_id"
    static let userID = "userID"
    static let channelID = "channelID"
    static let body = "body"
    static let username = "username"
    static let timestamp = "date"
}

struct Message {
    public private(set) var id: String
    public private(set) var userID: String
    public private(set) var channelID: String
    public private(set) var body: String
    public private(set) var username: String
    public private(set) var timestamp: String
    
    init(id: String = "", userID: String = "", channelID: String = "", body: String = "", username: String = "", timestamp: String = "") {
        self.id = id
        self.userID = userID
        self.channelID = channelID
        self.body = body
        self.username = username
        self.timestamp = timestamp
    }
    
    init(json: JSON) {
        self.id = json[SerializationKey.id].stringValue
        self.userID = json[SerializationKey.userID].stringValue
        self.channelID = json[SerializationKey.channelID].stringValue
        self.body = json[SerializationKey.body].stringValue
        self.username = json[SerializationKey.username].stringValue
        self.timestamp = json[SerializationKey.timestamp].stringValue
    }
    
    init?(_ dataArray: [Any]) {
        guard let id = dataArray[0] as? String,
            let userID = dataArray[1] as? String,
            let channelID = dataArray[2] as? String,
            let body = dataArray[3] as? String,
            let username = dataArray[4] as? String,
            let timestamp = dataArray[5] as? String else { return nil }
        
        self.id = id
        self.userID = userID
        self.channelID = channelID
        self.body = body
        self.username = username
        self.timestamp = timestamp
    }
}
