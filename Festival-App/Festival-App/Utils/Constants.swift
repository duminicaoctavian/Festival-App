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
//let baseURL = "http://localhost:3000"
let baseURL = "https://pacific-anchorage-10639.herokuapp.com"
let baseLocalURL = "http://localhost:3000"

struct StoryboardID {
    static let profileViewController = "Profile"
    static let SWRevealViewController = "SWRevealViewController"
    static let loginViewController = "LoginViewController"
}

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
    case deleteLocation = "deleteLocation"
    case updateLocation = "updateLocation"
    case locationDeleted = "locationDeleted"
    case locationUpdated = "locationUpdated"
    case locationCreated = "locationCreated"
    case userTypingUpdate = "userTypingUpdate"
}

enum BackendType: String {
    case clientServer = "Client Server"
    case serverless = "Serverless"
}

struct FirebaseChild {
    static let users = "users"
    static let artists = "artists"
}

struct Route {
    static let baseAWS = "https://s3.eu-central-1.amazonaws.com/octaviansuniversalbucket"
    static let defaultProfilePicture = "https://s3.eu-central-1.amazonaws.com/octaviansuniversalbucket/profileDefault.png"
    static let artists = "\(baseURL)/artists"
    static let products = "\(baseURL)/products"
    static let users = "\(baseURL)/users"
    static let channels = "\(baseURL)/channels"
    static let messages = "\(baseURL)/messages"
    static let news = "\(baseURL)/news"
    static let locations = "\(baseURL)/locations"
    static let loginUser = "\(baseURL)/users/login"
    static let logoutUser = "\(baseURL)/users/me/token"
    static let randomQuestion = "\(baseURL)/questions/random"
    static let addArtistID = "\(baseURL)/users/addArtist"
}

struct NotificationName {
    static let webViewsLoaded = Notification.Name("webviewsLoaded")
}

struct Segue {
    static let logout = "logoutSegue"
    static let toHomeFromLogin = "toHomeFromLogin"
    static let toRegister = "toRegister"
    static let toHomeFromRegister = "toHomeFromRegister"
    static let toChat = "toChat"
    static let toProducts = "toProducts"
    static let toProductDetails = "toProductDetails"
    static let toWinTickets = "toWinTickets"
}

struct UserDefaultsKey {
    static let token = "token"
    static let loggedIn = "loggedIn"
    static let user = "user"
    static let isServerless = "isServerless"
}

struct Header {
    static let header = ["Content-Type": "application/json; charset=utf-8"]
    static let bearerHeader = ["Access-Client": "\(AuthService.shared.authToken)"]
    static let bearerHeaderTitle = "Access-Client"
}

struct AnimationParameter {
    static let xStartScale: CGFloat = 0.95
    static let yStartScale: CGFloat = 0.95
    static let zStartScale: CGFloat = 1.0
    static let xEndScale: CGFloat = 1.0
    static let yEndScale: CGFloat = 1.0
    static let zEndScale: CGFloat = 1.0
    static let duration = 0.3
}

enum Alpha {
    static let highlighted: CGFloat = 1.0
    static let unhighlighted: CGFloat = 0.3
}

enum UserMenuOption: String {
    case home = "Home"
    case news = "News"
    case artists = "Artists"
    case lineup = "Lineup"
    case accommodation = "Accommodation"
    case shop = "Shop"
    
    static var rawValues: [String] {
        get {
            let options: [UserMenuOption] = [.home, .news, .artists, .lineup, .accommodation, .shop]
            var rawValues = [String]()
            options.forEach { (option) in
                rawValues.append(option.rawValue)
            }
            return rawValues
        }
    }
}

enum ProductCategory: String {
    case men = "Men"
    case women = "Women"
    case accessories = "Accesories"
    case music = "Music"
    
    static var rawValues: [String] {
        get {
            let categories: [ProductCategory] = [.men, .women, .accessories, .music]
            var rawValues = [String]()
            categories.forEach { (category) in
                rawValues.append(category.rawValue)
            }
            return rawValues
        }
    }
}

enum DateFormat: String {
    case ddMMYYYYhhmm = "dd.MM.YYYY HH:mm"
    case HHmm = "HH:mm"
}
