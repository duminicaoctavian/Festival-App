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

class NewsService {
    static let instance = NewsService()
    
    var news = [News]()
    var count = 0
    var loaded = false
    
    func findAllNews(completion: @escaping CompletionHandler) {
        Alamofire.request("\(URL_GET_NEWS)", method: .get, parameters: nil, encoding: JSONEncoding.default, headers: BEARER_HEADER).responseJSON { (response) in
            if response.result.error == nil {
                guard let data = response.data else { return }
                do {
                    let json = try JSON(data: data)
                    let array = json["news"].arrayValue
                    for item in array {
                        let _id = item["_id"].stringValue
                        let title = item["title"].stringValue
                        let timeStamp = item["date"].stringValue
                        let description = item["description"].stringValue
                        let url = item["URL"].stringValue
                        let news = News(_id: _id, title: title, date: timeStamp, description: description, url: url)
                        self.news.append(news)
                    }
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
    
    
    
    func clearNews() {
        news.removeAll()
    }
}
