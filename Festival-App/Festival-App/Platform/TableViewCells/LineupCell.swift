//
//  LineupCell.swift
//  Festival-App
//
//  Created by Duminica Octavian on 15/04/2018.
//  Copyright © 2018 Duminica Octavian. All rights reserved.
//

import UIKit

private struct Constants {
    static let captionCornerRadius: CGFloat = 2.0
    static let captionColor = UIColor.timelineCaptionColor
    static let tickAssetName = "tick"
    static let addAssetName = "addChannelButton"
}

class LineupCell: UITableViewCell {
    
    @IBOutlet weak var artistImageView: CircleImage!
    @IBOutlet weak var timestampLabel: UILabel!
    @IBOutlet weak var artistNameLabel: UILabel!
    @IBOutlet weak var addButton: UIButton!
    
    var timelinePoint = TimelinePoint()
    
    var timeline = Timeline() {
        didSet {
            setNeedsDisplay()
        }
    }
    
    var didAddToOwnTimeline: (() -> ())?

    var captionCornerRadius = Constants.captionCornerRadius
    var captionColor = Constants.captionColor
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func draw(_ rect: CGRect) {
        guard let sublayers = contentView.layer.sublayers else { return }
        
        for layer in sublayers {
            if layer is CAShapeLayer {
                layer.removeFromSuperlayer()
            }
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
    
    @IBAction func onAddTapped(_ sender: Any) {
        didAddToOwnTimeline?()
    }
}

extension LineupCell: LineupItemView {
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
    
    func displayTimestamp(_ timestamp: String) {
        timestampLabel.text = timestamp
    }
    
    func displayArtistName(_ name: String) {
        artistNameLabel.text = name
    }
    
    func changeButton() {
        addButton.setImage(UIImage(named: Constants.tickAssetName), for: .normal)
    }
    
    func resetButton() {
        addButton.setImage(UIImage(named: Constants.addAssetName), for: .normal)
    }
}
