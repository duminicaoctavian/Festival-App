//
//  Constants.swift
//  Festival-App
//
//  Created by Duminica Octavian on 21/02/2018.
//  Copyright © 2018 Duminica Octavian. All rights reserved.
//

import Foundation

enum Stages: String {
    case Main = "Main"
    case Resistance = "Resistance"
    case Live = "Live"
    case Oasis = "Oasis"
}

typealias CompletionHandler = (_ Success: Bool) -> ()

let USER_MENU_OPTIONS = ["Home", "News", "Artists", "Lineup", "Accomodation", "Merch"]
let PRODUCT_CATEGORIES = ["Men", "Women", "Accesories", "Music"]
let USER_MENU_CELL_IDENTIFIER = "userMenuCell"
let ARTIST_CELL_IDENTIFIER = "artistCell"
let PRODUCT_CATEGORY_CELL_IDENTIFIER = "productCategoryCell"
let NEWS_CELL_IDENTIFIER = "newsCell"
let PRODUCT_CELL_IDENTIFIER = "productCell"
let PRODUCT_VC_IDENTIFIER = "MerchVC"

// URL Constants
let BASE_URL = "http://localhost:3000"
//let BASE_URL = "https://pacific-anchorage-10639.herokuapp.com"
let BASE_AWS = "https://s3.eu-central-1.amazonaws.com/octaviansuniversalbucket"
let URL_GET_ARTISTS = "\(BASE_URL)/artists"
let URL_GET_PRODUCTS = "\(BASE_URL)/products"
let URL_REGISTER_USER = "\(BASE_URL)/users" 
let URL_LOGIN_USER = "\(BASE_URL)/users/login"
let URL_LOGOUT_USER = "\(BASE_URL)/users/me/token"
let URL_GET_CHANNELS = "\(BASE_URL)/channels"
let URL_GET_MESSAGES = "\(BASE_URL)/messages"
let URL_USER_BY_EMAIL = "\(BASE_URL)/users"
let URL_GET_NEWS = "\(BASE_URL)/news"
let URL_PATCH_USER = "\(BASE_URL)/users"
let URL_GET_LOCATIONS = "\(BASE_URL)/locations"

// Notification constant
let NOTIF_USER_DATA_DID_CHANGE = Notification.Name("notifUserDataChanged")
let NOTIF_CHANNELS_LOADED = Notification.Name("channelsLoaded")
let NOTIF_CHANNEL_SELECTED = Notification.Name("channelSelected")
let NOTIF_WEBVIEWS_LOADED = Notification.Name("webViewsLoaded")
let NOTIF_USER_EDITED = Notification.Name("userEdited")

// Segues
let LOGOUT_SEGUE = "logoutSegue"
let TO_HOME_FROM_LOGIN = "toHomeFromLogin"
let TO_REGISTER = "toRegister"
let TO_HOME_FROM_REGISTER = "toHomeFromRegister"
let TO_CHAT = "toChat"

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
    "X-Auth": "\(AuthService.instance.authToken)"
]
