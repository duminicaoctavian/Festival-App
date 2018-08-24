//
//  NewsView.swift
//  Festival-App
//
//  Created by Octavian Duminica on 05/08/2018.
//  Copyright © 2018 Duminica Octavian. All rights reserved.
//

import Foundation

protocol NewsView: class {
    func setupTableViewAutomaticCellDimension()
    func setupSlideMenu()
    func startActivityIndicator()
    func stopActivityIndicator()
    func showTableView()
    func hideTableView()
    func reloadData()
    func showStatusBar()
}
