//
//  TimelinePoint.swift
//  Festival-App
//
//  Created by Duminica Octavian on 15/04/2018.
//  Copyright © 2018 Duminica Octavian. All rights reserved.
//

import Foundation

private struct Constants {
    static let diameter: CGFloat = 12.9
    static let lineWidth: CGFloat = 4.0
}

struct TimelinePoint {
    var diameter: CGFloat
    var lineWidth: CGFloat
    var color: UIColor
    var position = CGPoint(x: 0, y: 0)
    
    init() {
        self.diameter = Constants.diameter
        self.lineWidth = Constants.lineWidth
        self.color = UIColor.black
    }
    
    public func draw(view: UIView) {
        let path = UIBezierPath(ovalIn: CGRect(x: position.x, y: position.y, width: diameter, height: diameter))
        
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = path.cgPath
        shapeLayer.strokeColor = color.cgColor
        shapeLayer.fillColor = UIColor.white.cgColor
        shapeLayer.lineWidth = lineWidth

        view.layer.addSublayer(shapeLayer)
    }
}
