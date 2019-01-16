//
//  Application.swift
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
    static let resumeURL = "resumeURL"
    static let offerID = "offerID"
    static let phone = "phone"
    static let projects = "projects"
    static let dateApplied = "dateApplied"
}

struct Application {
    public var id: String
    public var userID: String
    public var resumeURL: String
    public var offerID: String
    public var phone: String
    public var projects: String
    public var dateApplied: String
    
    init() {
        self.id = ""
        self.userID = ""
        self.resumeURL = ""
        self.offerID = ""
        self.phone = ""
        self.projects = ""
        self.dateApplied = ""
    }
    
    init(id: String, userID: String, resumeURL: String, offerID: String, phone: String, projects: String, dateApplied: String) {
        self.id = id
        self.userID = userID
        self.resumeURL = resumeURL
        self.phone = phone
        self.offerID = offerID
        self.projects = projects
        self.dateApplied = dateApplied
    }
    
    init(json: JSON) {
        self.id = json[SerializationKey.id].stringValue
        self.userID = json[SerializationKey.userID].stringValue
        self.resumeURL = json[SerializationKey.resumeURL].stringValue
        self.phone = json[SerializationKey.phone].stringValue
        self.offerID = json[SerializationKey.offerID].stringValue
        self.projects = json[SerializationKey.projects].stringValue
        self.dateApplied = json[SerializationKey.dateApplied].stringValue
    }
    
    static func generateBody(userID: String, offerID: String, projects: String, resumeURL: String, phone: String) -> [String: String] {
        let body = [
            SerializationKey.userID: userID,
            SerializationKey.offerID: offerID,
            SerializationKey.projects: projects,
            SerializationKey.resumeURL: resumeURL,
            SerializationKey.phone: phone
        ]
        return body
    }
}
