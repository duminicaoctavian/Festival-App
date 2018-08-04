//
//  ChannelCell.swift
//  Smack
//
//  Created by Octavian on 07/01/2018.
//  Copyright © 2018 Octavian. All rights reserved.
//

import UIKit

class ChannelCell: UITableViewCell {
    
    @IBOutlet weak var channelName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        if selected {
            self.layer.backgroundColor = UIColor(white: 1, alpha: 0.2).cgColor
        } else {
            self.layer.backgroundColor = UIColor.clear.cgColor
        }
    }
    
    func configureCell(channel: Channel) {
        let title = channel.name ?? ""
        channelName.text = "#\(title)"
        
        channelName.font = UIFont(name: "Avenir-Medium", size: 18)
        
        for id in MessageService.instance.unreadChannels {
            if id == channel.id {
                channelName.font = UIFont(name: "Avenir-Heavy", size: 30)
            }
        }
    }
}
