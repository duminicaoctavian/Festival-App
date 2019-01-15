//
//  UIColor+Extensions.swift
//  Festival-App
//
//  Created by Octavian Duminica on 15/01/2019.
//  Copyright © 2019 Duminica Octavian. All rights reserved.
//

import UIKit

extension UIColor {
    
    static func RGB(_ red: CGFloat, _ green: CGFloat, _ blue: CGFloat, alpha: CGFloat = 1.0) -> UIColor {
        return UIColor(red: red / 255.0, green: green / 255.0, blue: blue / 255.0, alpha: alpha)
    }
    
    static let appBlue = UIColor.RGB(22, 149, 163)
    
    static let appBlack = UIColor.RGB(30, 30, 30)
    
    static let appGray = UIColor.RGB(220, 220, 220)
    
    static let appRed = UIColor.RGB(233, 20, 20)
    
    static let appYellow = UIColor.RGB(255, 168, 0)
    
    static let appGreen = UIColor.RGB(60, 179, 113)
}

