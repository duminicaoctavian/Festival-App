//
//  ProductItemView.swift
//  Festival-App
//
//  Created by Octavian Duminica on 06/08/2018.
//  Copyright © 2018 Duminica Octavian. All rights reserved.
//

import Foundation

protocol ProductItemView {
    func displayName(_ name: String)
    func displayPrice(_ price: String)
    func displayImage(_ URLString: String)
}
