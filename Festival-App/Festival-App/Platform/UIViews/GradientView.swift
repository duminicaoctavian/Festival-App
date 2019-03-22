//
//  GradientView.swift
//  Festival-App
//
//  Created by Duminica Octavian on 21/02/2018.
//  Copyright © 2018 Duminica Octavian. All rights reserved.
//

import UIKit

class GradientView: UIView {
    
    private var gradientLayer = CAGradientLayer()

    @IBInspectable var topColor: UIColor = .black {
        didSet {
            self.setNeedsLayout()
        }
    }
    
    @IBInspectable var bottomColor: UIColor = .black {
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

    override func layoutSubviews() {
        removeAllSublayers()
        makeGradientLayer()
        layer.insertSublayer(gradientLayer, at: 0)
    }
    
    private func removeAllSublayers() {
        layer.sublayers?.forEach({ (layer) in
            if layer is CAGradientLayer {
                layer.removeFromSuperlayer()
            }
        })
    }
    
    private func makeGradientLayer() {
        gradientLayer.colors = [topColor.cgColor, bottomColor.cgColor]
        gradientLayer.startPoint = CGPoint(x: startX, y: startY)
        gradientLayer.endPoint = CGPoint(x: endX, y: endY)
        gradientLayer.frame = self.bounds
    }
}
