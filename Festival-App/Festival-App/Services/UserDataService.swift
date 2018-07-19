//
//  UserDataService.swift
//  Smack
//
//  Created by Octavian on 03/01/2018.
//  Copyright © 2018 Octavian. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class UserDataService {
    static let instance = UserDataService()
    
    public private(set) var id = ""
    public private(set) var email = ""
    public private(set) var name = ""
    
    
    func setUserData(id: String, email: String, name: String) {
        self.id = id
        self.email = email
        self.name = name
    }
    
    func editUser(username: String, password: String, imageUrl: String, completion: @escaping CompletionHandler) {
        
        let body: [String: Any] = [
            "username": username,
            "password": password,
            "imageURL": imageUrl
        ]
        
        Alamofire.request("\(URL_PATCH_USER)/\(AuthService.instance.id)", method: .patch, parameters: body, encoding: JSONEncoding.default, headers: BEARER_HEADER).responseJSON { (response) in
            
            print(self.id)
            if response.result.error == nil {
                guard let data = response.data else {return}
                
                if response.response?.statusCode == 400 {
                    
                    completion(false)
                    
                } else {
                    do {
                        let json = try JSON(data: data)
                        AuthService.instance.userEmail = json["email"].stringValue
                        AuthService.instance.userName = json["username"].stringValue
                        AuthService.instance.imageUrl = json["imageURL"].stringValue
                        let id = json["_id"].stringValue
                        
                        UserDataService.instance.setUserData(id: id, email: AuthService.instance.userEmail, name: AuthService.instance.userName)
                    } catch {
                        debugPrint(error)
                        completion(false)
                    }
                    completion(true)
                }
                
            } else {
                completion(false)
                debugPrint(response.result.error as Any)
            }
        }
    }
    
    
    
    func logoutUser() {
        id = ""
        email = ""
        name = ""
        AuthService.instance.isLoggedIn = false
        AuthService.instance.userEmail = ""
        AuthService.instance.authToken = ""
        MessageService.instance.clearChannels()
        MessageService.instance.clearMessages()
    }
}
