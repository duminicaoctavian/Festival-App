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
    
    //update the layout of the view
    @IBInspectable var topColor: UIColor = #colorLiteral(red: 0.2535281653, green: 0.09283451598, blue: 0.4339581428, alpha: 1) {
        didSet {
            self.setNeedsLayout()
        }
    }
    
    @IBInspectable var bottomColor: UIColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1) {
        didSet {
            self.setNeedsLayout()
        }
    }
    
    //called whenever we change our variables
    override func layoutSubviews() {
        let gradientLayer = CAGradientLayer() //Core Animation
        gradientLayer.colors = [topColor.cgColor, bottomColor.cgColor]
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 1, y: 1)
        gradientLayer.frame = self.bounds
        self.layer.insertSublayer(gradientLayer, at: 0) //insert at first layer
    }
}

