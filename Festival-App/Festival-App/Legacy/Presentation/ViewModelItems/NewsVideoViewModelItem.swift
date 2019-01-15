//
//  NewsVideoViewModelItem.swift
//  Festival-App
//
//  Created by Octavian Duminica on 06/08/2018.
//  Copyright © 2018 Duminica Octavian. All rights reserved.
//

import Foundation

class NewsVideoViewModelItem: NewsViewModelItem {
    var type: NewsViewModelItemType {
        return .video
    }
    
    var title: String
    var text: String
    var date: String
    var request: URLRequest
    
    init?(title: String, text: String, timestamp: String, videoURL: String) {
        guard let request = videoURL.generateRequest() else { return nil }
        guard let date = timestamp.convertFromISODate(toFormat: DateFormat.ddMMYYYYhhmm.rawValue) else { return nil }
        
        self.title = title
        self.text = text
        self.date = date
        self.request = request
    }
}
