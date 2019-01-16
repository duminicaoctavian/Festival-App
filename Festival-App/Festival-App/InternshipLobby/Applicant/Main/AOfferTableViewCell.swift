//
//  OfferTableViewCell.swift
//  Festival-App
//
//  Created by Octavian Duminica on 16/01/2019.
//  Copyright © 2019 Duminica Octavian. All rights reserved.
//

import UIKit

class AOfferTableViewCell:
UITableViewCell {
    @IBOutlet weak var companyImageView: CircleImage!
    
    @IBOutlet weak var titleLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}


extension AOfferTableViewCell: AOfferItemView {
    func displayTitle(_ text: String) {
        titleLabel.text = text
    }
    
    func displayImage(_ URLString: String) {
        companyImageView.loadImageUsingCache(withURLString: URLString)
    }
}
