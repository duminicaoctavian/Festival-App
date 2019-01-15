//
//  NewsImageViewModelItem.swift
//  Festival-App
//
//  Created by Octavian Duminica on 06/08/2018.
//  Copyright © 2018 Duminica Octavian. All rights reserved.
//

import Foundation

class NewsImageViewModelItem: NewsViewModelItem {
    var type: NewsViewModelItemType {
        return .image
    }
    
    var title: String
    var text: String
    var date: String
    var imageURL: String
    
    init?(title: String, text: String, timestamp: String, imageURL: String) {
        guard let date = timestamp.convertFromISODate(toFormat: DateFormat.ddMMYYYYhhmm.rawValue) else { return nil }
        
        self.title = title
        self.text = text
        self.date = date
        self.imageURL = imageURL
    }
}
