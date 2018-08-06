//
//  Extensions.swift
//  Festival-App
//
//  Created by Duminica Octavian on 15/04/2018.
//  Copyright © 2018 Duminica Octavian. All rights reserved.
//

import Foundation

extension String {
    func getYoutubeID() -> String? {
        return URLComponents(string: self)?.queryItems?.first(where: { $0.name == "v" })?.value
    }
    
    func convertFromISODate(toFormat format: String) -> String? {
        var ISODate = self
        let end = ISODate.index(ISODate.endIndex, offsetBy: -5)
        ISODate = String(ISODate[..<end])
        
        let ISOFormatter = ISO8601DateFormatter()
        let timezoneDate = ISOFormatter.date(from: ISODate.appending("Z"))
        
        let newFormatter = DateFormatter()
        newFormatter.dateFormat = format
        
        if let date = timezoneDate {
            let date = newFormatter.string(from: date)
            return date
        } else {
            return nil
        }
    }
    
    func generateRequest() -> URLRequest? {
        guard let videoID = self.getYoutubeID() else { return nil }
        let URLString = "http://www.youtube.com/embed/\(videoID)"
        guard let URL = URL(string: URLString) else { return nil }
        return URLRequest(url: URL)
    }
}
