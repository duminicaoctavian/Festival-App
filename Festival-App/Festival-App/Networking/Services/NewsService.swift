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
    static let shared = NewsService()
    
    var newsItems = [NewsViewModelItem]()
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
                        
                        weakSelf.handleVideoItem(news)
                        weakSelf.handleImageItem(news)

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
        newsItems.removeAll()
    }
    
    private func handleVideoItem(_ news: News) {
        guard let videoURL = news.videoURL else { return }
        if let videoItem = NewsVideoViewModelItem(title: news.title, text: news.description,
                                                  timestamp: news.date, videoURL: videoURL) {
            newsItems.append(videoItem)
        }
    }
    
    private func handleImageItem(_ news: News) {
        guard let imageURL = news.imageURL else { return }
        if let imageItem = NewsImageViewModelItem(title: news.title, text: news.description,
                                                  timestamp: news.date, imageURL: imageURL) {
            newsItems.append(imageItem)
        }
    }
}
