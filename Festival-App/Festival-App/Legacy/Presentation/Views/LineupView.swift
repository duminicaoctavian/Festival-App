//
//  LineupView.swift
//  Festival-App
//
//  Created by Octavian Duminica on 24/08/2018.
//  Copyright © 2018 Duminica Octavian. All rights reserved.
//

import Foundation

protocol LineupView: class {
    func setupSlideMenu()
    func hideNavigationBar()
    func startActivityIndicator()
    func stopActivityIndicator()
    func highlightItem(button: Highlightable)
    func unHighlightItems(buttons: [Highlightable])
    func reloadData()
}
