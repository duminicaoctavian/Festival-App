//
//  PictureNewsCell.swift
//  Festival-App
//
//  Created by Octavian Duminica on 05/08/2018.
//  Copyright © 2018 Duminica Octavian. All rights reserved.
//

import UIKit

class PictureNewsCell: UITableViewCell {
    
    @IBOutlet weak var newsImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var newsTextLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    var item: NewsViewModelItem? {
        didSet {
            guard let item = item as? NewsImageViewModelItem else { return }
            
            titleLabel.text = item.title
            newsTextLabel.text = item.text
            dateLabel.text = item.date
            newsImageView.loadImageUsingCache(withURLString: item.imageURL)
        }
    }
}
