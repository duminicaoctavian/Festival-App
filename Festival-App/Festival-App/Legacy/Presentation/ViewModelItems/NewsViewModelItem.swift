//
//  NewsViewModelItem.swift
//  Festival-App
//
//  Created by Octavian Duminica on 06/08/2018.
//  Copyright © 2018 Duminica Octavian. All rights reserved.
//

import Foundation

enum NewsViewModelItemType {
    case video
    case image
}

protocol NewsViewModelItem {
    var type: NewsViewModelItemType { get }
}
