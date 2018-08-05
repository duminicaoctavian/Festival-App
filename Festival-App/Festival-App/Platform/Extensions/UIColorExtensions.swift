//
//  UIColorExtensions.swift
//  Festival-App
//
//  Created by Octavian Duminica on 04/08/2018.
//  Copyright © 2018 Duminica Octavian. All rights reserved.
//

import UIKit

extension UIColor {
    convenience init(red: CGFloat, green: CGFloat, blue: CGFloat) {
        self.init(red: red/255, green: green/255, blue: blue/255, alpha: 1.0)
    }
    
    static var buttonColor: UIColor {
        get {
            return UIColor.init(red: 61, green: 22, blue: 104)
        }
    }
    
    static var navigationBarColor: UIColor {
        get {
            return UIColor.init(red: 56, green: 20, blue: 95)
        }
    }
    
    static var tabBarColor: UIColor {
        get {
            return UIColor.init(red: 0, green: 39, blue: 54)
        }
    }
    
    static var backgroundBlue: UIColor {
        get {
            return UIColor.init(red: 0, green: 39, blue: 54)
        }
    }
    
    static var backgroundRed: UIColor {
        get {
            return UIColor.init(red: 39, green: 0, blue: 15)
        }
    }
    
    static var backgroundYellow: UIColor {
        get {
            return UIColor.init(red: 45, green: 42, blue: 0)
        }
    }
    
    static var backgroundGreen: UIColor {
        get {
            return UIColor.init(red: 0, green: 38, blue: 19)
        }
    }
}
