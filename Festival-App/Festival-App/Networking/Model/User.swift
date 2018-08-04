//
//  User.swift
//  Festival-App
//
//  Created by Duminica Octavian on 22/04/2018.
//  Copyright © 2018 Duminica Octavian. All rights reserved.
//

import Foundation

class User: NSObject {
    
    public private(set) var _id: String
    public private(set) var username: String
    public private(set) var email: String
    public private(set) var imageURL: String
    
    init(_id: String, username: String, email: String, imageURL: String) {
        self._id = _id
        self.username = username
        self.email = email
        self.imageURL = imageURL
    }
    
    
}

extension User: NSCoding {
    func encode(with aCoder
    
}
