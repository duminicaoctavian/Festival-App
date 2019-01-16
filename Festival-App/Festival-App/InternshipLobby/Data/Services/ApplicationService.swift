//
//  ApplicationService.swift
//  Festival-App
//
//  Created by Octavian Duminica on 16/01/2019.
//  Copyright © 2019 Duminica Octavian. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

private struct Constants {
    static let applicationsSerializationKey = "applications"
}

class ApplicationService {
    
    static let shared = ApplicationService()
    
    var applications = [Application]()
    
    func apply(userID: String, offerID: String, projects: String, resumeURL: String, phone: String, companyID: String, offerTitle: String, completion: @escaping CompletionHandler) {
        
        let body = Application.generateBody(userID: userID, offerID: offerID, projects: projects, resumeURL: resumeURL, phone: "0745047302", companyID: companyID, offerTitle: offerTitle, userImageURL: AuthService.shared.user.imageURL)
        
        Alamofire.request(Route.postApplication, method: .post, parameters: body, encoding: JSONEncoding.default, headers: Header.bearerHeader).responseJSON { [weak self] (response) in
            
            guard let weakSelf = self else { completion(false); return }
            
            if response.result.error == nil {
                guard let data = response.data else { completion(false); return }
                if response.response?.statusCode == 400 {
                    completion(false)
                    return
                } else {
                    do {
                        let json = try JSON(data: data)
                        let application = Application(json: json)
                        
                        print(application.resumeURL, application.userID)
//                        weakSelf.applications.append(application)
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
    
    func getAllApplications(forCompany companyID: String, completion: @escaping CompletionHandler) {
        Alamofire.request("\(Route.postApplication)/\(companyID)", method: .get, parameters: nil, encoding: JSONEncoding.default, headers: Header.bearerHeader).responseJSON { [weak self] (response) in
            
            guard let weakSelf = self else { completion(false); return }
            
            if response.result.error == nil {
                guard let data = response.data else { completion(false); return }
                do {
                    let json = try JSON(data: data)
                    let array = json[Constants.applicationsSerializationKey].arrayValue
                    for item in array {
                        let application = Application(json: item)
                        weakSelf.applications.append(application)
                    }
                    completion(true)
                } catch {
                    debugPrint(error)
                    completion(false)
                    return
                }
            } else {
                debugPrint(response.result.error as Any)
                completion(false)
                return
            }
        }
    }
    
    
    func clearApplications() {
        applications.removeAll()
    }
}
