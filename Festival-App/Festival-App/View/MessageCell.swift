//
//  MessageCell.swift
//  Smack
//
//  Created by Octavian on 07/01/2018.
//  Copyright © 2018 Octavian. All rights reserved.
//

import UIKit

class MessageCell: UITableViewCell {

    // Outlets
    @IBOutlet weak var usernameLbl: UILabel!
    @IBOutlet weak var timeStampLbl: UILabel!
    @IBOutlet weak var messageBodyLbl: UILabel!
    @IBOutlet weak var otherUsernameLbl: UILabel!
    @IBOutlet weak var otherTimeStampLbl: UILabel!
    @IBOutlet weak var otherImageView: UIImageView!
    @IBOutlet weak var myImageView: UIImageView!
    @IBOutlet weak var otherMessageBodyLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configureCell(message: Message) {
        if message.userId == AuthService.instance.id {
            otherImageView.isHidden = true
            otherTimeStampLbl.isHidden = true
            otherUsernameLbl.isHidden = true
            usernameLbl.isHidden = false
            timeStampLbl.isHidden = false
            messageBodyLbl.isHidden = false
            myImageView.isHidden = false
            otherMessageBodyLbl.isHidden = true
            
            messageBodyLbl.text = message.message
            usernameLbl.text = AuthService.instance.userName
            
            // 2017-07-13T21:49:25.590Z
            guard var isoDate = message.timeStamp else { return }
            let end = isoDate.index(isoDate.endIndex, offsetBy: -5)
            isoDate = String(isoDate[..<end])
            
            let isoFormatter = ISO8601DateFormatter()
            let chatDate = isoFormatter.date(from: isoDate.appending("Z"))
            
            let newFormatter = DateFormatter()
            newFormatter.dateFormat = "MMM d, h:mm a"
            
            if let finalDate = chatDate {
                let finalDate = newFormatter.string(from: finalDate)
                timeStampLbl.text = finalDate
            }
        } else {
            otherImageView.isHidden = false
            otherTimeStampLbl.isHidden = false
            otherUsernameLbl.isHidden = false
            usernameLbl.isHidden = true
            timeStampLbl.isHidden = true
            messageBodyLbl.isHidden = true
            myImageView.isHidden = true
            otherMessageBodyLbl.isHidden = false
            
            otherMessageBodyLbl.text = message.message
            otherUsernameLbl.text = message.userName
            
            // 2017-07-13T21:49:25.590Z
            guard var isoDate = message.timeStamp else { return }
            let end = isoDate.index(isoDate.endIndex, offsetBy: -5)
            isoDate = String(isoDate[..<end])
            
            let isoFormatter = ISO8601DateFormatter()
            let chatDate = isoFormatter.date(from: isoDate.appending("Z"))
            
            let newFormatter = DateFormatter()
            newFormatter.dateFormat = "MMM d, h:mm a"
            
            if let finalDate = chatDate {
                let finalDate = newFormatter.string(from: finalDate)
                otherTimeStampLbl.text = finalDate
            }
        }
    }
}
