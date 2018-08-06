//
//  ProductCategoryCell.swift
//  Festival-App
//
//  Created by Duminica Octavian on 24/02/2018.
//  Copyright © 2018 Duminica Octavian. All rights reserved.
//

import UIKit

class ProductCategoryCell: UITableViewCell {
    
    static let identifier = "productCategoryCell"
    
    @IBOutlet weak var customView: HalfRoundedView!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var categoryImageView: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configureCell(category: String) {
        categoryLabel.text = category
        categoryImageView.image = UIImage(named: "\(category)")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        if selected {
            customView.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.7)
        }
    }
    
    override func setHighlighted(_ highlighted: Bool, animated: Bool) {
        super.setHighlighted(highlighted, animated: animated)
        
        if highlighted {
             customView.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.7)
        }
    }
}
