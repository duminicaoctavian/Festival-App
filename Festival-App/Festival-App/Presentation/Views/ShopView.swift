//
//  ShopView.swift
//  Festival-App
//
//  Created by Octavian Duminica on 06/08/2018.
//  Copyright © 2018 Duminica Octavian. All rights reserved.
//

import Foundation

protocol ShopView: class {
    func startActivityIndicator()
    func stopActivityIndicator()
    func reloadData()
    func navigateToShopCategoryScreen()
}
