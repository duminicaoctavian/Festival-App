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
    static let companyID = "companyID"
    static let offerTitle = "offerTitle"
    static let userImageURL = "userImageURL"
}

struct Application {
    public var id: String
    public var userID: String
    public var companyID: String
    public var resumeURL: String
    public var offerID: String
    public var phone: String
    public var projects: String
    public var dateApplied: String
    public var offerTitle: String
    public var userImageURL: String
    
    init() {
        self.id = ""
        self.userID = ""
        self.resumeURL = ""
        self.offerID = ""
        self.phone = ""
        self.projects = ""
        self.dateApplied = ""
        self.companyID = ""
        self.offerTitle = ""
        self.userImageURL = ""
    }
    
    init(id: String, userID: String, resumeURL: String, offerID: String, phone: String, projects: String, dateApplied: String, companyID: String, offerTitle: String, userImageURL: String) {
        self.id = id
        self.userID = userID
        self.resumeURL = resumeURL
        self.phone = phone
        self.offerID = offerID
        self.projects = projects
        self.dateApplied = dateApplied
        self.companyID = companyID
        self.offerTitle = offerTitle
        self.userImageURL = userImageURL
    }
    
    init(json: JSON) {
        self.id = json[SerializationKey.id].stringValue
        self.userID = json[SerializationKey.userID].stringValue
        self.resumeURL = json[SerializationKey.resumeURL].stringValue
        self.phone = json[SerializationKey.phone].stringValue
        self.offerID = json[SerializationKey.offerID].stringValue
        self.projects = json[SerializationKey.projects].stringValue
        self.dateApplied = json[SerializationKey.dateApplied].stringValue
        self.companyID = json[SerializationKey.companyID].stringValue
        self.offerTitle = json[SerializationKey.offerTitle].stringValue
        self.userImageURL = json[SerializationKey.userImageURL].stringValue
    }
    
    static func generateBody(userID: String, offerID: String, projects: String, resumeURL: String, phone: String, companyID: String, offerTitle: String, userImageURL: String) -> [String: String] {
        let body = [
            SerializationKey.userID: userID,
            SerializationKey.offerID: offerID,
            SerializationKey.projects: projects,
            SerializationKey.resumeURL: resumeURL,
            SerializationKey.phone: phone,
            SerializationKey.companyID: companyID,
            SerializationKey.offerTitle: offerTitle,
            SerializationKey.userImageURL: userImageURL
        ]
        return body
    }
}
