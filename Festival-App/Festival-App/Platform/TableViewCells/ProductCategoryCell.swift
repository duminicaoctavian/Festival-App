//
//  ProductCategoryCell.swift
//  Festival-App
//
//  Created by Duminica Octavian on 24/02/2018.
//  Copyright © 2018 Duminica Octavian. All rights reserved.
//

import UIKit

class ProductCategoryCell: UITableViewCell {
    
    @IBOutlet weak var customView: HalfRoundedView!
    @IBOutlet weak var productCategoryLbl: UILabel!
    @IBOutlet weak var productCategoryImageView: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configureCell(category: String) {
        productCategoryLbl.text = category
        productCategoryImageView.image = UIImage(named: "\(category)")
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