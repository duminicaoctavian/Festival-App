//
//  Timeline.swift
//  Festival-App
//
//  Created by Duminica Octavian on 15/04/2018.
//  Copyright © 2018 Duminica Octavian. All rights reserved.
//

import Foundation

private struct Constants {
    static let width: CGFloat = 2.0
    static let leftMargin: CGFloat = 130.0
}

struct Timeline {
    var width: CGFloat
    var leftMargin: CGFloat
    var (frontColor, backColor) = (UIColor.black, UIColor.black)
    var (start, middle, end) = (CGPoint(x: 0, y: 0), CGPoint(x: 0, y: 0), CGPoint(x: 0, y: 0))
    
    init() {
        self.width = Constants.width
        self.leftMargin = Constants.leftMargin
    }
    
    func draw(view: UIView) {
        draw(view: view, from: start, to: middle, color: frontColor)
        draw(view: view, from: middle, to: end, color: backColor)
    }
    
    private func draw(view: UIView, from: CGPoint, to: CGPoint, color: UIColor) {
        let path = UIBezierPath()
        path.move(to: from)
        path.addLine(to: to)
        
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = path.cgPath
        shapeLayer.strokeColor = color.cgColor
        shapeLayer.lineWidth = width
        
        view.layer.addSublayer(shapeLayer)
    }
}
