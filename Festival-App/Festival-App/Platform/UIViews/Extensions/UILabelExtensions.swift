//
//  UILabelExtensions.swift
//  Festival-App
//
//  Created by Octavian Duminica on 05/08/2018.
//  Copyright © 2018 Duminica Octavian. All rights reserved.
//

import Foundation

extension UILabel: Highlightable {
    func highlight() {
        self.alpha = Alpha.highlighted
    }
    
    func unHighlight() {
        self.alpha = Alpha.unhighlighted
    }
}
