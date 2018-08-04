//
//  HomeView.swift
//  Festival-App
//
//  Created by Octavian Duminica on 04/08/2018.
//  Copyright © 2018 Duminica Octavian. All rights reserved.
//

import Foundation

protocol HomeView: class {
    func setupSlideMenu()
    func hideNavigationBar()
    func navigateToChatScreen()
    func navigateToBuyTickets()
}
