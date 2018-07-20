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
    
    var userName: String {
        get {
            return defaults.value(forKey: USER_NAME) as? String ?? ""
        }
        set {
            defaults.set(newValue, forKey: USER_NAME)
        }
    }
    
    var id: String {
        get {
            return defaults.value(forKey: USER_ID) as? String ?? ""
        }
        set {
            defaults.set(newValue, forKey: USER_ID)
        }
    }
    
    var imageUrl: String {
        get {
            return defaults.value(forKey: USER_IMAGE_URL) as? String ?? ""
        }
        set {
            defaults.set(newValue, forKey: USER_IMAGE_URL)
        }
    }
    
    func registerUser(username: String, email: String, password: String, completion: @escaping CompletionHandler) {
        
        let lowerCaseEmail = email.lowercased()
        
        let body: [String: Any] = [
            "username": username,
            "email": lowerCaseEmail,
            "password": password
        ]
        
        Alamofire.request(URL_REGISTER_USER, method: .post, parameters: body, encoding: JSONEncoding.default, headers: HEADER).responseJSON { (response) in
            if response.result.error == nil {
                guard let data = response.data else {return}
                if response.response?.statusCode == 400 {
                    completion(false)
                } else {
                    do {
                        let json = try JSON(data: data)
                        self.userEmail = json["email"].stringValue
                        self.userName = json["username"].stringValue
                        self.id = json["_id"].stringValue
                        self.imageUrl = json["imageURL"].stringValue
                        if response.response?.allHeaderFields["Access-Client"] != nil {
                            self.authToken = (response.response?.allHeaderFields["Access-Client"] as? String)!
                        }
                        
                        UserDataService.instance.setUserData(id: self.id, email: self.userEmail, name: self.userName)
                    } catch {
                        debugPrint(error)
                        completion(false)
                    }
                    self.isLoggedIn = true
                    completion(true)
                }
                
            } else {
                completion(false)
                debugPrint(response.result.error as Any)
            }
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
                    self.userEmail = json["email"].stringValue
                    self.userName = json["username"].stringValue
                    self.id = json["_id"].stringValue
                    self.imageUrl = json["imageURL"].stringValue
                    self.authToken = (response.response?.allHeaderFields["Access-Client"] as? String)!
                    
                    UserDataService.instance.setUserData(id: self.id, email: self.userEmail, name: self.userName)
                } catch {
                    debugPrint(error)
                    completion(false)
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
        
        Alamofire.request(URL_LOGOUT_USER, method: .delete, parameters: nil, encoding: JSONEncoding.default, headers: BEARER_HEADER).responseJSON { (response) in
            
            if response.result.error == nil {
                self.isLoggedIn = false
                self.userEmail = ""
                self.authToken = ""
                self.userName = ""
                self.imageUrl = ""
                self.id = ""
                UserDefaults.standard.set(nil, forKey: USER_PROFILE_IMG)
                completion(true)
            } else {
                completion(false)
                debugPrint(response.result.error as Any)
            }
        }
    }
    
    func findUserById(id: String, completion: @escaping (_ newUser: User) -> Void) {
        Alamofire.request("\(URL_USER_BY_EMAIL)/\(id)", method: .get, parameters: nil, encoding: JSONEncoding.default, headers: HEADER).responseJSON { (response) in
            
            if response.result.error == nil {
                guard let data = response.data else {return}
                do {
                    let json = try JSON(data: data)
                    let id = json["_id"].stringValue
                    let email = json["email"].stringValue
                    let username = json["username"].stringValue
                    let imageUrl = json["imageURL"].stringValue
                    
                    let newUser = User(_id: id, userName: username, email: email, imageUrl: imageUrl)
                    
                    completion(newUser)
                } catch {
                    debugPrint(error)
                }
                
            } else {
                completion(User())
                debugPrint(response.result.error as Any)
            }
        }
    }
    
    func findUserByEmail(completion: @escaping CompletionHandler) {
        Alamofire.request("\(URL_USER_BY_EMAIL)/\(userEmail)", method: .get, parameters: nil, encoding: JSONEncoding.default, headers: HEADER).responseJSON { (response) in
            
            if response.result.error == nil {
                guard let data = response.data else {return}
                do {
                    let json = try JSON(data: data)
                    let id = json["_id"].stringValue
                    let email = json["email"].stringValue
                    let username = json["username"].stringValue
                    
                    
                    UserDataService.instance.setUserData(id: id, email: email, name: username)
                    completion(true)
                } catch {
                    debugPrint(error)
                }
                
            } else {
                completion(false)
                debugPrint(response.result.error as Any)
            }
        }
    }
}
