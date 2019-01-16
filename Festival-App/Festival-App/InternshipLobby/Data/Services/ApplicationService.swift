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

class ApplicationService {
    
    static let shared = ApplicationService()
    
    var applications = [Application]()
    
    func apply(userID: String, offerID: String, projects: String, resumeURL: String, phone: String, completion: @escaping CompletionHandler) {
        
        let body = Application.generateBody(userID: userID, offerID: offerID, projects: projects, resumeURL: resumeURL, phone: "0745047302")
        
        Alamofire.request("\(Route.postApplication)/5c3f31881fc59d0015bd99da", method: .post, parameters: body, encoding: JSONEncoding.default, headers: Header.bearerHeader).responseJSON { [weak self] (response) in
            
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
                        weakSelf.applications.append(application)
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
    
    func clearApplications() {
        applications.removeAll()
    }
}
