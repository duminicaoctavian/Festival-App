//
//  VideoNewsItemView.swift
//  Festival-App
//
//  Created by Octavian Duminica on 05/08/2018.
//  Copyright © 2018 Duminica Octavian. All rights reserved.
//

import Foundation

protocol VideoNewsItemView {
    func displayTitle(_ title: String)
    func displayNewsText(_ text: String)
    func displayDate(_ date: String)
    func displayYoutubeThumbnail(_ URLRequest: URLRequest)
}
