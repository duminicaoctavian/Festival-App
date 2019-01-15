//
//  UIFont+Extensions.swift
//  Festival-App
//
//  Created by Octavian Duminica on 15/01/2019.
//  Copyright © 2019 Duminica Octavian. All rights reserved.
//

import UIKit

extension UIFont {
    
    convenience init(_ font: Font, of size: CGFloat) {
        self.init(name: font.name, size: size)!
    }
}

enum Font {
    case avenirLight, avenirMedium, avenirHeavy
    
    fileprivate var name: String {
        switch self {
        case .avenirLight:
            return "Avenir-Light"
        case .avenirMedium:
            return "Avenir-Medium"
        case .avenirHeavy:
            return "Avenir-Heavy"
        }
    }
}
