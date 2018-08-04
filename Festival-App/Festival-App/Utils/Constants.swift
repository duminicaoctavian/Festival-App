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

typealias CompletionHandler = (_ Success: Bool) -> ()

enum Stages: String {
    case Main = "Main"
    case Resistance = "Resistance"
    case Live = "Live"
    case Oasis = "Oasis"
}

enum UserMenuOptions: String {
    case home = "Home"
    case news = "News"
    case artists = "Artists"
    case lineup = "Lineup"
    case accommodation = "Accommodation"
    case merch = "Merch"
}

private let baseURL = "https://pacific-anchorage-10639.herokuapp.com"
private let baseLocalURL = "http://localhost:3000"

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
    static let userDataDidChange = Notification.Name("userDataDidChange")
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
    static let loggenIn = "loggedIn"
    static let user = "user"
}
// User Defaults
let TOKEN_KEY = "token"
let LOGGED_IN_KEY = "loggedIn"
let USER_EMAIL = "userEmail"
let USER_NAME = "userName"
let USER_ID = "userId"
let USER_IMAGE_URL = "userImageUrl"
let USER_PROFILE_IMG = "userProfileImg"

// Headers
let HEADER = [
    "Content-Type" : "application/json; charset=utf-8"
]

var BEARER_HEADER = [
    "Access-Client": "\(AuthService.instance.authToken)"
]
