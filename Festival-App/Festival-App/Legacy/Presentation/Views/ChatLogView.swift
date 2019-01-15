//
//  ChatLogView.swift
//  Festival-App
//
//  Created by Octavian Duminica on 10/08/2018.
//  Copyright © 2018 Duminica Octavian. All rights reserved.
//

import Foundation

protocol ChatLogView: class {
    func reloadData()
    func startActivityIndicator()
    func stopActivityIndicator()
    func setupSlideMenu()
    func setupTableViewAutomaticCellDimension()
    func navigateToHomeScreen()
    func scrollToIndex(_ index: Int)
    func displayChannelName(_ name: String)
    func displayNoChannelsAvailable()
    func resetInputTextField()
    func hideInputView()
    func showInputView()
}
