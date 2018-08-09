//
//  WinTicketsView.swift
//  Festival-App
//
//  Created by Octavian Duminica on 09/08/2018.
//  Copyright © 2018 Duminica Octavian. All rights reserved.
//

import Foundation

protocol WinTicketsView: class {
    func presentImagePicker()
    func displayQuestion(_ question: String)
    func navigateToHomeScreen()
    func showWrongAnswerAlert()
    func showCorrectAnswerAlert()
    func roundImageCorners()
}
