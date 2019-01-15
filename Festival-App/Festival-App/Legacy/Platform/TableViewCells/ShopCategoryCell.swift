//
//  ShopCategoryCell.swift
//  Festival-App
//
//  Created by Duminica Octavian on 24/02/2018.
//  Copyright © 2018 Duminica Octavian. All rights reserved.
//

import UIKit

class ShopCategoryCell: UITableViewCell {
    
    @IBOutlet weak var customView: HalfRoundedView!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var categoryImageView: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        if selected {
            setRoundedViewBackgroundColor()
        }
    }
    
    override func setHighlighted(_ highlighted: Bool, animated: Bool) {
        super.setHighlighted(highlighted, animated: animated)
        
        if highlighted {
             setRoundedViewBackgroundColor()
        }
    }
}

extension ShopCategoryCell: ShopCategoryItemView {
    func displayCategoryName(_ name: String) {
        categoryLabel.text = name
    }
    
    func displayCategoryImage(_ name: String) {
        categoryImageView.image = UIImage(named: name)
    }
    
    func setRoundedViewBackgroundColor() {
        customView.backgroundColor = UIColor.halfRoundedViewColor
    }
}

