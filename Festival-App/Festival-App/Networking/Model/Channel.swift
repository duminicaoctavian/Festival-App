//
//  Channel.swift
//  Festival-App
//
//  Created by Octavian on 07/01/2018.
//  Copyright © 2018 Octavian. All rights reserved.
//

import Foundation
import SwiftyJSON

private struct SerializationKey {
    static let id = "_id"
    static let name = "name"
    static let description = "description"
}

struct Channel {
    public private(set) var id: String
    public private(set) var name: String
    public private(set) var description: String
    
    init(json: JSON) {
        self.id = json[SerializationKey.id].stringValue
        self.name = json[SerializationKey.name].stringValue
        self.description = json[SerializationKey.description].stringValue
    }
    
    init?(_ dataArray: [Any]) {
        guard let id = dataArray[0] as? String,
            let name = dataArray[1] as? String,
            let description = dataArray[2] as? String else { return nil }
        
        self.id = id
        self.name = name
        self.description = description
    }
}
