//
//  ProductDetailsView.swift
//  Festival-App
//
//  Created by Octavian Duminica on 06/08/2018.
//  Copyright © 2018 Duminica Octavian. All rights reserved.
//

import Foundation

protocol ProductDetailsView: class {
    func navigateToProductsScreen()
    func displayProductImage(_ URLString: String)
    func displayPrice(_ price: String)
    func displayName(_ name: String)
    func displayCarousel()
    func disableScrollingForCarousel()
}
