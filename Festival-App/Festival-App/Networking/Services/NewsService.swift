//
//  NewsService.swift
//  Festival-App
//
//  Created by Duminica Octavian on 26/03/2018.
//  Copyright © 2018 Duminica Octavian. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

private struct Constants {
    static let newsSerializationKey = "news"
}

class NewsService {
    static let instance = NewsService()
    
    var news = [News]()
    var loaded = false
    
    func findAllNews(completion: @escaping CompletionHandler) {
        Alamofire.request(Route.news, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: Header.bearerHeader).responseJSON { [weak self] (response) in
            
            guard let weakSelf = self else { completion(false); return }
            
            if response.result.error == nil {
                guard let data = response.data else { completion(false); return }
                do {
                    let json = try JSON(data: data)
                    let array = json[Constants.newsSerializationKey].arrayValue
                    for item in array {
                        let news = News(json: item)
                        weakSelf.news.append(news)
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
    
    func clearNews() {
        news.removeAll()
    }
}
