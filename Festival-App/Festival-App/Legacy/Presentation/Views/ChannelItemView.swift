//
//  ChannelItemView.swift
//  Festival-App
//
//  Created by Octavian Duminica on 10/08/2018.
//  Copyright © 2018 Duminica Octavian. All rights reserved.
//

import Foundation

protocol ChannelItemView {
    func displayName(_ name: String)
    func displayUnreadChannel()
    func displayReadChannel()
    func highlightChannel()
    func unhighlightChannel()
}
