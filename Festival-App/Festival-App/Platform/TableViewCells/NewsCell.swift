//
//  NewsCell.swift
//  Festival-App
//
//  Created by Duminica Octavian on 24/02/2018.
//  Copyright © 2018 Duminica Octavian. All rights reserved.
//

import UIKit

class NewsCell: UITableViewCell {
    
    static let identifier = "newsCell"
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var newsTextLabel: UILabel!
    @IBOutlet weak var webView: UIWebView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}

extension NewsCell: NewsItemView {
    func displayTitle(_ title: String) {
        titleLabel.text = title
    }
    
    func displayNewsText(_ text: String) {
        newsTextLabel.text = text
    }
    
    func displayYoutubeThumbnail(_ URLRequest: URLRequest) {
        webView.loadRequest(URLRequest)
    }
    
    func displayDate(_ date: String) {
        dateLabel.text = date
    }
}

