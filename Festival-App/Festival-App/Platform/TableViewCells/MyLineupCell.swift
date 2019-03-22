//
//  MyLineupCell.swift
//  Festival-App
//
//  Created by Octavian Duminica on 25/08/2018.
//  Copyright © 2018 Duminica Octavian. All rights reserved.
//

import UIKit

private struct Constants {
    static let captionCornerRadius: CGFloat = 2.0
    static let captionColor = UIColor.timelineCaptionColor
}

class MyLineupCell: UITableViewCell {
    
    @IBOutlet weak var artistImageView: CircleImage!
    @IBOutlet weak var timestampLabel: UILabel!
    @IBOutlet weak var artistNameLabel: UILabel!
    
    var timelinePoint = TimelinePoint()
    
    var timeline = Timeline() {
        didSet {
            setNeedsDisplay()
        }
    }
    
    var captionCornerRadius = Constants.captionCornerRadius
    var captionColor = Constants.captionColor
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func draw(_ rect: CGRect) {
        guard let sublayers = contentView.layer.sublayers else { return }
        
        for layer in sublayers where layer is CAShapeLayer {
            layer.removeFromSuperlayer()
        }
        
        timelinePoint.position = CGPoint(x: timeline.leftMargin + timeline.width / 2, y: timestampLabel.frame.origin.y + 15)
        timeline.start = CGPoint(x: timelinePoint.position.x + timelinePoint.diameter / 2, y: 0)
        timeline.middle = CGPoint(x: timeline.start.x, y: timelinePoint.position.y)
        timeline.end = CGPoint(x: timeline.start.x, y: bounds.size.height)
        timeline.draw(view: contentView)
        timelinePoint.draw(view: contentView)
        
        drawCaption()
    }
    
    private func drawCaption() {
        let offset: CGFloat = 16
        
        let captionRect = CGRect(
            x: timestampLabel.frame.origin.x - offset / 2,
            y: timestampLabel.frame.origin.y,
            width: timestampLabel.intrinsicContentSize.width + offset,
            height: timestampLabel.intrinsicContentSize.height + offset
        )
        
        let path = UIBezierPath(roundedRect: captionRect, cornerRadius: captionCornerRadius)
        let startPoint = CGPoint(x: captionRect.origin.x, y: captionRect.origin.y + captionRect.height / 2 - 8)
        path.move(to: startPoint)
        path.addLine(to: startPoint)
        path.addLine(to: CGPoint(x: captionRect.origin.x - 8, y: captionRect.origin.y + captionRect.height / 2))
        path.addLine(to: CGPoint(x: captionRect.origin.x, y: captionRect.origin.y + captionRect.height / 2 + 8))
        
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = path.cgPath
        shapeLayer.fillColor = captionColor.cgColor
        
        contentView.layer.insertSublayer(shapeLayer, below: timestampLabel.layer)
    }
}

extension MyLineupCell: MyLineupItemView {
    func displayTimestampAndStage(_ timestamp: String, and stage: String) {
        timestampLabel.text = "\(timestamp) @\(stage)"
    }
    
    func displayUpperTimeline() {
        timeline.upperColor = .lightGray
    }
    
    func displayLowerTimeline() {
        timeline.lowerColor = .lightGray
    }
    
    func hideUpperTimeline() {
        timeline.upperColor = .clear
    }
    
    func hideLowerTimeline() {
        timeline.lowerColor = .clear
    }
    
    func displayArtistImage(_ URLString: String) {
        artistImageView.loadImageUsingCache(withURLString: URLString)
    }
    
    func displayArtistName(_ name: String) {
        artistNameLabel.text = name
    }
}
