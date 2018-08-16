//
//  QuestionService.swift
//  Festival-App
//
//  Created by Octavian Duminica on 10/08/2018.
//  Copyright © 2018 Duminica Octavian. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class QuestionService {
    static let shared = QuestionService()
    
    var question: Question?
    
    func getRandomQuestion(completion: @escaping CompletionHandler) {
        Alamofire.request(Route.randomQuestion, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: Header.bearerHeader).responseJSON { [weak self] (response) in
            guard let weakSelf = self else { return }
            
            if response.result.error == nil {
                guard let data = response.data else { completion(false); return }
                do {
                    let json = try JSON(data: data)
                    let question = Question(json: json)
                    weakSelf.question = question
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
}
