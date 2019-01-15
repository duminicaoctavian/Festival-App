//
//  OfferItemView.swift
//  Festival-App
//
//  Created by Octavian Duminica on 05/09/2018.
//  Copyright © 2018 Duminica Octavian. All rights reserved.
//

import Foundation

protocol OfferItemView {
    func displayTitle(_ title: String)
    func displayDescription(_ description: String)
    func displayPrice(_ price: String)
    func roundPriceView()
}
