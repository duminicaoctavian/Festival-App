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
    static let shared = AuthService()
    
    let defaults = UserDefaults.standard

    var isLoggedIn: Bool {
        get {
            return defaults.bool(forKey: UserDefaultsKey.loggedIn)
        }
        set {
            defaults.set(newValue, forKey: UserDefaultsKey.loggedIn)
        }
    }
    
    var authToken: String {
        get {
            return defaults.value(forKey: UserDefaultsKey.token) as? String ?? ""
        }
        set {
            defaults.set(newValue, forKey: UserDefaultsKey.token)
        }
    }
    
    var user: User {
        get {
            return getUserFromDefaults() ?? User()
        }
        set {
            saveUserToDefauls(user: newValue)
        }
    }
    
    private func getUserFromDefaults() -> User? {
        if let data = UserDefaults.standard.data(forKey: UserDefaultsKey.user) {
            if let user = NSKeyedUnarchiver.unarchiveObject(with: data) as? User {
                return user
            } else {
                return nil
            }
        } else {
            return nil
        }
    }
    
    private func saveUserToDefauls(user: User) {
        let data = NSKeyedArchiver.archivedData(withRootObject: user)
        UserDefaults.standard.set(data, forKey: UserDefaultsKey.user)
    }
    
    func registerUser(username: String, email: String, password: String, completion: @escaping CompletionHandler) {
        
        let lowercaseEmail = email.lowercased()
        let body = User.generateBody(username: username, email: lowercaseEmail, password: password)
        
        Alamofire.request(Route.users, method: .post, parameters: body, encoding: JSONEncoding.default, headers: Header.header).responseJSON { [weak self] (response) in
            
            guard let weakSelf = self else { completion(false); return }
            
            if response.result.error == nil {
                guard let data = response.data else { completion(false); return }
                if response.response?.statusCode == 400 {
                    completion(false)
                    return
                } else {
                    do {
                        let json = try JSON(data: data)
                        let user = User(json: json)
                        if response.response?.allHeaderFields[Header.bearerHeaderTitle] != nil {
                            guard let token = response.response?.allHeaderFields[Header.bearerHeaderTitle] as? String else { completion(false); return }
                            weakSelf.authToken = token
                            weakSelf.user = user
                        } else {
                            completion(false)
                            return
                        }
                    } catch {
                        debugPrint(error)
                        completion(false)
                        return
                    }
                    weakSelf.isLoggedIn = true
                    completion(true)
                }
                
            } else {
                debugPrint(response.result.error as Any)
                completion(false)
                return
            }
        }
    }
    
    func loginUser(email: String, password: String, completion: @escaping CompletionHandler) {

        let lowercaseEmail = email.lowercased()
        let body = User.generateBody(email: lowercaseEmail, password: password)

        Alamofire.request(Route.loginUser, method: .post, parameters: body, encoding: JSONEncoding.default, headers: Header.header).responseJSON { [weak self] (response) in
            
            guard let weakSelf = self else { completion(false); return }
            
            if response.result.error == nil {
                guard let data = response.data else { completion(false); return }
                do {
                    let json = try JSON(data: data)
                    let user = User(json: json)
                    guard let token = (response.response?.allHeaderFields[Header.bearerHeaderTitle] as? String) else { completion(false); return }
                    weakSelf.authToken = token
                    weakSelf.user = user
                } catch {
                    debugPrint(error)
                    completion(false)
                    return
                }
                weakSelf.isLoggedIn = true
                completion(true)
            } else {
                debugPrint(response.result.error as Any)
                completion(false)
                return
            }
        }
    }
    
    func logoutUser(completion: @escaping CompletionHandler) {
        
        Alamofire.request(Route.logoutUser, method: .delete, parameters: nil, encoding: JSONEncoding.default, headers: Header.bearerHeader).responseJSON { [weak self] (response) in
            
            guard let weakSelf = self else { completion(false); return }
            
            if response.result.error == nil {
                weakSelf.isLoggedIn = false
                weakSelf.authToken = ""
                weakSelf.user = User()
                UserDefaults.standard.set(nil, forKey: UserDefaultsKey.user)
                completion(true)
            } else {
                debugPrint(response.result.error as Any)
                completion(false)
                return
            }
        }
    }
    
    func findUserByID(id: String, completion: @escaping (_ user: User?) -> Void) {
        Alamofire.request("\(Route.users)/\(id)", method: .get, parameters: nil, encoding: JSONEncoding.default, headers: Header.header).responseJSON { [weak self] (response) in
            
            guard let _ = self else { completion(nil); return }
            
            if response.result.error == nil {
                guard let data = response.data else { completion(nil); return }
                do {
                    let json = try JSON(data: data)
                    let user = User(json: json)
                    completion(user)
                } catch {
                    debugPrint(error)
                    completion(nil)
                    return
                }
                
            } else {
                debugPrint(response.result.error as Any)
                completion(nil)
                return
            }
        }
    }
    
    func editUser(username: String, password: String, imageURL: String, completion: @escaping CompletionHandler) {
        
        let body = User.generateBody(username: username, password: password, imageURL: imageURL)
        
        Alamofire.request("\(Route.users)/\(AuthService.shared.user.id)", method: .patch, parameters: body, encoding: JSONEncoding.default, headers: Header.bearerHeader).responseJSON { [weak self] (response) in
            
            guard let _ = self else { completion(false); return }
            
            if response.result.error == nil {
                guard let data = response.data else { completion(false); return }
                
                if response.response?.statusCode == 400 {
                    completion(false)
                    return
                } else {
                    do {
                        let json = try JSON(data: data)
                        let user = User(json: json)
                        
                        AuthService.shared.user = user
                    } catch {
                        debugPrint(error)
                        completion(false)
                        return
                    }
                    completion(true)
                }
                
            } else {
                debugPrint(response.result.error as Any)
                completion(false)
                return
            }
        }
    }
}
