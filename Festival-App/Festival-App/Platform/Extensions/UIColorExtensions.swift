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
        return UIColor(red: 61, green: 22, blue: 104)
    }
    
    static var navigationBarColor: UIColor {
        return UIColor(red: 56, green: 20, blue: 95)
    }
    
    static var halfRoundedViewColor: UIColor {
        return UIColor(red: 0, green: 0, blue: 0, alpha: 0.7)
    }
    
    static var tabBarColor: UIColor {
        return UIColor(red: 0, green: 39, blue: 54)
    }
    
    static var backgroundBlue: UIColor {
        return UIColor(red: 0, green: 39, blue: 54)
    }
    
    static var backgroundRed: UIColor {
        return UIColor(red: 39, green: 0, blue: 15)
    }
    
    static var backgroundYellow: UIColor {
        return UIColor(red: 45, green: 42, blue: 0)
    }
    
    static var backgroundGreen: UIColor {
        return UIColor(red: 0, green: 38, blue: 19)
    }
    
    static var timelinePointColor: UIColor {
        return UIColor(red: 0, green: 60, blue: 84)
    }
}
