//
//  CPendingOfferTableViewCell.swift
//  Festival-App
//
//  Created by Octavian Duminica on 16/01/2019.
//  Copyright © 2019 Duminica Octavian. All rights reserved.
//

import UIKit

class CPendingOfferTableViewCell: UITableViewCell {
    @IBOutlet weak var offerTitleLabel: UILabel!
    @IBOutlet weak var applicantImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}

extension CPendingOfferTableViewCell: CPendingOfferItemView {
    func displayOfferTitle(_ text: String) {
        offerTitleLabel.text = text
    }
    
    func displayApplicantImage(_ imageURLString: String) {
        applicantImageView.loadImageUsingCache(withURLString: imageURLString)
    }
}
