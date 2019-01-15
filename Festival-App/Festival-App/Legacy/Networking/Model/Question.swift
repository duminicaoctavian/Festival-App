//
//  Question.swift
//  Festival-App
//
//  Created by Octavian Duminica on 10/08/2018.
//  Copyright © 2018 Duminica Octavian. All rights reserved.
//

import Foundation
import SwiftyJSON

private struct SerializationKey {
    static let id = "_id"
    static let question = "question"
    static let answer = "answer"
}

struct Question {
    public private(set) var id: String
    public private(set) var question: String
    public private(set) var answer: String
    
    init(json: JSON) {
        self.id = json[SerializationKey.id].stringValue
        self.question = json[SerializationKey.question].stringValue
        self.answer = json[SerializationKey.answer].stringValue
    }
}
