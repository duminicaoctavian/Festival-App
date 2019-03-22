//
//  VideoNewsCell.swift
//  Festival-App
//
//  Created by Duminica Octavian on 24/02/2018.
//  Copyright © 2018 Duminica Octavian. All rights reserved.
//

import UIKit

class VideoNewsCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var newsTextLabel: UILabel!
    @IBOutlet weak var webView: UIWebView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    var item: NewsViewModelItem? {
        didSet {
            guard let item = item as? NewsVideoViewModelItem else { return }
            
            titleLabel.text = item.title
            newsTextLabel.text = item.text
            dateLabel.text = item.date
            webView.loadRequest(item.request)
        }
    }
}
