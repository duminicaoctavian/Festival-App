//
//  PictureNewsCell.swift
//  Festival-App
//
//  Created by Octavian Duminica on 05/08/2018.
//  Copyright © 2018 Duminica Octavian. All rights reserved.
//

import UIKit

class PictureNewsCell: UITableViewCell {
    
    static let identifier = "pictureNewsCell"
    
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
//
//extension PictureNewsCell: PictureNewsItemView {
//    func displayTitle(_ title: String) {
//        titleLabel.text = title
//    }
//
//    func displayNewsText(_ text: String) {
//        newsTextLabel.text = text
//    }
//
//    func displayNewsImage(_ URLString: String) {
//        newsImageView.loadImageUsingCache(withURLString: URLString)
//    }
//
//    func displayDate(_ date: String) {
//        dateLabel.text = date
//    }
//}
