//
//  GradientView.swift
//  Festival-App
//
//  Created by Duminica Octavian on 21/02/2018.
//  Copyright © 2018 Duminica Octavian. All rights reserved.
//

import UIKit

@IBDesignable //lets the class know it needs to be rendered on the storyboard, useful for custom work
class GradientView: UIView {
    
    // update the layout of the view
    @IBInspectable var topColor: UIColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1) {
        didSet {
            self.setNeedsLayout()
        }
    }
    
    @IBInspectable var bottomColor: UIColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1) {
        didSet {
            self.setNeedsLayout()
        }
    }
    
    @IBInspectable var startX: CGFloat = 0 {
        didSet {
            self.setNeedsLayout()
        }
    }
    
    @IBInspectable var startY: CGFloat = 0 {
        didSet {
            self.setNeedsLayout()
        }
    }
    
    @IBInspectable var endX: CGFloat = 1 {
        didSet {
            self.setNeedsLayout()
        }
    }
    
    @IBInspectable var endY: CGFloat = 1 {
        didSet {
            self.setNeedsLayout()
        }
    }
    
    //called whenever we change our variables
    override func layoutSubviews() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [topColor.cgColor, bottomColor.cgColor]
        gradientLayer.startPoint = CGPoint(x: startX, y: startY)
        gradientLayer.endPoint = CGPoint(x: endX, y: endY)
        gradientLayer.frame = self.bounds
        self.layer.insertSublayer(gradientLayer, at: 0) //insert at first layer
        super.prepareForInterfaceBuilder()
    }
}

