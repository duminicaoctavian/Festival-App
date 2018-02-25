//
//  AuthService.swift
//  Festival-App
//
//  Created by Duminica Octavian on 25/02/2018.
//  Copyright © 2018 Duminica Octavian. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class AuthService {
    static let instance = AuthService()
    
    let defaults = UserDefaults.standard

    var isLoggedIn: Bool {
        get {
            return defaults.bool(forKey: LOGGED_IN_KEY)
        }
        set {
            defaults.set(newValue, forKey: LOGGED_IN_KEY)
        }
    }

    var authToken: String {
        get {
            return defaults.value(forKey: TOKEN_KEY) as? String ?? ""
        }
        set {
            defaults.set(newValue, forKey: TOKEN_KEY)
        }
    }

    var userEmail: String {
        get {
            return defaults.value(forKey: USER_EMAIL) as? String ?? ""
        }
        set {
            defaults.set(newValue, forKey: USER_EMAIL)
        }
    }
    
    func loginUser(email: String, password: String, completion: @escaping CompletionHandler) {

        let lowerCaseEmail = email.lowercased()

        let body: [String: Any] = [
            "email": lowerCaseEmail,
            "password": password
        ]

        Alamofire.request(URL_LOGIN_USER, method: .post, parameters: body, encoding: JSONEncoding.default, headers: HEADER).responseJSON { (response) in
            if response.result.error == nil {
                guard let data = response.data else {return}
                do {
                    let json = try JSON(data: data)
                    self.userEmail = json["user"].stringValue
                    self.authToken = (response.response?.allHeaderFields["X-Auth"] as? String)!
                } catch {
                    debugPrint(error)
                }
                self.isLoggedIn = true
                completion(true)
            } else {
                completion(false)
                debugPrint(response.result.error as Any)
            }
        }
    }
    
    func logoutUser(completion: @escaping CompletionHandler) {
        AuthService.instance.isLoggedIn = false
        AuthService.instance.userEmail = ""
        AuthService.instance.authToken = ""
        completion(true)
    }
}