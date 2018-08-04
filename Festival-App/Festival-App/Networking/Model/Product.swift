//
//  Product.swift
//  Festival-App
//
//  Created by Duminica Octavian on 25/02/2018.
//  Copyright © 2018 Duminica Octavian. All rights reserved.
//

import Foundation
import SwiftyJSON

private struct SerializationKey {
    static let id = "_id"
    static let name = "name"
    static let price = "price"
    static let category = "category"
    static let imageURL = "imageURL"
}

struct Product {
    public private(set) var id: String
    public private(set) var name: String
    public private(set) var price: String
    public private(set) var category: String
    public private(set) var imageURL: String
    
    init(json: JSON) {
        self.id = json[SerializationKey.id].stringValue
        self.name = json[SerializationKey.name].stringValue
        self.price = json[SerializationKey.price].stringValue
        self.category = json[SerializationKey.category].stringValue
        self.imageURL = json[SerializationKey.imageURL].stringValue
    }
}
