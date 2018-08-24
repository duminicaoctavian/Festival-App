//
//  LineupCell.swift
//  Festival-App
//
//  Created by Duminica Octavian on 15/04/2018.
//  Copyright © 2018 Duminica Octavian. All rights reserved.
//

import UIKit

class LineupCell: UITableViewCell {
    
    @IBOutlet weak var artistImageView: CircleImage!
    @IBOutlet weak var timestampLabel: UILabel!
    @IBOutlet weak var artistNameLabel: UILabel!
    
    open var timelinePoint = TimelinePoint() {
        didSet {
            self.setNeedsDisplay()
        }
    }
    open var timeline = Timeline() {
        didSet {
            self.setNeedsDisplay()
        }
    }

    open var bubbleRadius: CGFloat = 2.0 {
        didSet {
            if (bubbleRadius < 0.0) {
                bubbleRadius = 0.0
            } else if (bubbleRadius > 6.0) {
                bubbleRadius = 6.0
            }
            
            self.setNeedsDisplay()
        }
    }
    
    open var bubbleColor = UIColor(red: 56.0/255.0, green: 27.0/255.0, blue: 90.0/255.0, alpha: 1.0)
    
    override open func awakeFromNib() {
        super.awakeFromNib()
    }

    override open func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    override open func draw(_ rect: CGRect) {
        for layer in self.contentView.layer.sublayers! {
            if layer is CAShapeLayer {
                layer.removeFromSuperlayer()
            }
        }
        
        timelinePoint.position = CGPoint(x: timeline.leftMargin + timeline.width / 2, y: timestampLabel.frame.origin.y + 15)

        timeline.start = CGPoint(x: timelinePoint.position.x + timelinePoint.diameter / 2, y: 0)
        timeline.middle = CGPoint(x: timeline.start.x, y: timelinePoint.position.y)
        timeline.end = CGPoint(x: timeline.start.x, y: self.bounds.size.height)
        timeline.draw(view: self.contentView)
        
        timelinePoint.draw(view: self.contentView)
        
        if let title = timestampLabel.text, !title.isEmpty {
            drawBubble()
        }
    }
    
    fileprivate func drawBubble() {
        let offset: CGFloat = 16
        let bubbleRect = CGRect(
            x: timestampLabel.frame.origin.x - offset / 2,
            y: timestampLabel.frame.origin.y,
            width: timestampLabel.intrinsicContentSize.width + offset,
            height: timestampLabel.intrinsicContentSize.height + offset)
        
        let path = UIBezierPath(roundedRect: bubbleRect, cornerRadius: bubbleRadius)
        let startPoint = CGPoint(x: bubbleRect.origin.x, y: bubbleRect.origin.y + bubbleRect.height / 2 - 8)
        path.move(to: startPoint)
        path.addLine(to: startPoint)
        path.addLine(to: CGPoint(x: bubbleRect.origin.x - 8, y: bubbleRect.origin.y + bubbleRect.height / 2))
        path.addLine(to: CGPoint(x: bubbleRect.origin.x, y: bubbleRect.origin.y + bubbleRect.height / 2 + 8))

        let shapeLayer = CAShapeLayer()
        shapeLayer.path = path.cgPath
        shapeLayer.fillColor = bubbleColor.cgColor
        
        self.contentView.layer.insertSublayer(shapeLayer, below: timestampLabel.layer)
    }
    
    var didRequestToAddToOwnTimeline: ((_ cell:UITableViewCell) -> ())?
    
    @IBAction func onAddPressed(_ sender: Any) {
        self.didRequestToAddToOwnTimeline?(self)
    }
}

extension LineupCell: LineupItemView {
    func displayArtistImage(_ URLString: String) {
        artistImageView.loadImageUsingCache(withURLString: URLString)
    }
    
    func displayTimestamp(_ timestamp: String) {
        timestampLabel.text = timestamp
    }
    
    func displayArtistName(_ name: String) {
        artistNameLabel.text = name
    }
}
