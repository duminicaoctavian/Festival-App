//
//  PictureNewsItemView.swift
//  Festival-App
//
//  Created by Octavian Duminica on 05/08/2018.
//  Copyright © 2018 Duminica Octavian. All rights reserved.
//

import Foundation

protocol PictureNewsItemView {
    func displayTitle(_ title: String)
    func displayNewsText(_ text: String)
    func displayDate(_ date: String)
    func displayNewsImage(_ URLString: String)
}
