//
//  OfferCell.swift
//  Festival-App
//
//  Created by Octavian Duminica on 05/09/2018.
//  Copyright © 2018 Duminica Octavian. All rights reserved.
//

import Foundation

private struct Constants {
    static let priceViewCornerRadius: CGFloat = 10.0
}

class OfferCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var priceView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        roundPriceView()
    }
}

extension OfferCell: OfferItemView {
    func displayTitle(_ title: String) {
        titleLabel.text = title
    }
    
    func displayDescription(_ description: String) {
        descriptionLabel.text = description
    }
    
    func displayPrice(_ price: String) {
        priceLabel.text = "$\(price)"
    }
    
    func roundPriceView() {
        priceView.clipsToBounds = true
        priceView.layer.cornerRadius = Constants.priceViewCornerRadius
        priceView.layer.maskedCorners = [.layerMinXMaxYCorner]
    }
}
