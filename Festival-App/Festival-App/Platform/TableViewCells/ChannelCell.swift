//
//  ChannelCell.swift
//  Festival-App
//
//  Created by Octavian on 07/01/2018.
//  Copyright © 2018 Octavian. All rights reserved.
//

import UIKit

private struct Constants {
    static let unreadChannelFontFamily = "Avenir-Heavy"
    static let unreadChannelFontSize: CGFloat = 30.0
    static let readChannelFontFamily = "Avenir-Medium"
    static let readChannelFontSize: CGFloat = 18.0
}

class ChannelCell: UITableViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        if selected {
            highlightChannel()
        } else {
            unhighlightChannel()
        }
    }
}

extension ChannelCell: ChannelItemView {
    
    func highlightChannel() {
        layer.backgroundColor = UIColor(white: 1, alpha: 0.2).cgColor
    }
    
    func unhighlightChannel() {
        layer.backgroundColor = UIColor.clear.cgColor
    }
    
    func displayName(_ name: String) {
        nameLabel.text = "#\(name)"
    }
    
    func displayUnreadChannel() {
        nameLabel.font = UIFont(name: Constants.unreadChannelFontFamily, size: Constants.unreadChannelFontSize)
    }
    
    func displayReadChannel() {
        nameLabel.font = UIFont(name: Constants.readChannelFontFamily, size: Constants.readChannelFontSize)
    }
}
