//
//  MessageCell.swift
//  Smack
//
//  Created by Octavian on 07/01/2018.
//  Copyright © 2018 Octavian. All rights reserved.
//

import UIKit

class MessageCell: UITableViewCell {
    
    static let identifier = "MessageCell"
    
    // Outlets
    @IBOutlet weak var usernameLbl: UILabel!
    @IBOutlet weak var timeStampLbl: UILabel!
    @IBOutlet weak var messageBodyLbl: UILabel!
    @IBOutlet weak var otherUsernameLbl: UILabel!
    @IBOutlet weak var otherTimeStampLbl: UILabel!
    @IBOutlet weak var otherImageView: UIImageView!
    @IBOutlet weak var myImageView: UIImageView!
    @IBOutlet weak var otherMessageBodyLbl: UILabel!
    
    var imageUrlString: String?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configureCell(message: Message) {
        if message.userID == AuthService.instance.user.id {
            otherImageView.isHidden = true
            otherTimeStampLbl.isHidden = true
            otherUsernameLbl.isHidden = true
            usernameLbl.isHidden = false
            timeStampLbl.isHidden = false
            messageBodyLbl.isHidden = false
            myImageView.isHidden = false
            otherMessageBodyLbl.isHidden = true
            
            messageBodyLbl.text = message.body
            usernameLbl.text = AuthService.instance.user.username
            
            
            
            // 2017-07-13T21:49:25.590Z
            var isoDate = message.timestamp
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
            
            otherImageView.image = nil
            otherMessageBodyLbl.text = nil
            otherUsernameLbl.text = nil
            otherTimeStampLbl.text = nil
            
            let userId = message.userID
            let user = MessageService.instance.usersForChannel[userId]!
            
            self.otherUsernameLbl.text = user.username
            self.otherMessageBodyLbl.text = message.body
            
            // 2017-07-13T21:49:25.590Z
            var isoDate = message.timestamp
            let end = isoDate.index(isoDate.endIndex, offsetBy: -5)
            isoDate = String(isoDate[..<end])
            
            let isoFormatter = ISO8601DateFormatter()
            let chatDate = isoFormatter.date(from: isoDate.appending("Z"))
            
            let newFormatter = DateFormatter()
            newFormatter.dateFormat = "MMM d, h:mm a"
            
            if let finalDate = chatDate {
                let finalDate = newFormatter.string(from: finalDate)
                self.otherTimeStampLbl.text = finalDate
            }
            
            self.imageUrlString = user.imageURL
            
            let imageUrl = URL(string: user.imageURL)!
            
//            if let imageFromCache = globalCache.object(forKey: user.imageURL as AnyObject) as? UIImage {
//                self.otherImageView.image = imageFromCache
//                return
//            }
            
            // Start background thread so that image loading does not make app unresponsive
//            DispatchQueue.global(qos: .userInitiated).async {
//
//                let imageData = NSData(contentsOf: imageUrl)!
//
//                // When from background thread, UI needs to be updated on main_queue
//                DispatchQueue.main.async {
//                    let imageToCache = UIImage(data: imageData as Data)
//
//                    if self.imageUrlString! == user.imageURL {
//                        self.otherImageView.image = imageToCache
//                    }
//
//                    globalCache.setObject(imageToCache!, forKey: user.imageURL as AnyObject)
//                }
//            }
        }
    }
}
