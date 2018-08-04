//
//  Constants.swift
//  Festival-App
//
//  Created by Duminica Octavian on 21/02/2018.
//  Copyright © 2018 Duminica Octavian. All rights reserved.
//

import Foundation

// generate class diagram
// ruby generateEntityDiagram.rb ~/Documents/iOS/Degree/Festival-App/Festival-App/Festival-App/

typealias CompletionHandler = (_ success: Bool) -> ()
let baseURL = "https://pacific-anchorage-10639.herokuapp.com"
let baseLocalURL = "http://localhost:3000"

enum Stage: String {
    case main = "Main"
    case resistance = "Resistance"
    case live = "Live"
    case oasis = "Oasis"
}

enum Event: String {
    case newChannel = "newChannel"
    case channelCreated = "channelCreated"
    case newMessage = "newMessage"
    case messageCreated = "messageCreated"
    case newLocation = "newLocation"
    case locationCreated = "locationCreated"
    case userTypingUpdate = "userTypingUpdate"
}

struct Route {
    static let baseAWS = "https://s3.eu-central-1.amazonaws.com/octaviansuniversalbucket"
    static let artists = "\(baseURL)/artists"
    static let products = "\(baseURL)/products"
    static let users = "\(baseURL)/users"
    static let channels = "\(baseURL)/channels"
    static let messages = "\(baseURL)/messages"
    static let news = "\(baseURL)/news"
    static let locations = "\(baseURL)/locations"
    static let loginUser = "\(baseURL)/users/login"
    static let logoutUser = "\(baseURL)/users/me/token"
}

struct NotificationName {
    static let channelsLoaded = Notification.Name("channelsLoaded")
    static let channelSelected = Notification.Name("channelSelected")
    static let webviewsLoaded = Notification.Name("webviewsLoaded")
    static let userEdited = Notification.Name("userEdited")
}

struct Segue {
    static let logout = "logoutSegue"
    static let toHomeFromLogin = "toHomeFromLogin"
    static let toRegister = "toRegister"
    static let toHomeFromRegister = "toHomeFromRegister"
    static let toChat = "toChat"
    static let toMerch = "toMerch"
}

struct UserDefaultsKey {
    static let token = "token"
    static let loggedIn = "loggedIn"
    static let user = "user"
}

struct Header {
    static let header = ["Content-Type": "application/json; charset=utf-8"]
    static let bearerHeader = ["Access-Client": "\(AuthService.instance.authToken)"]
    static let bearerHeaderTitle = "Access-Client"
}
