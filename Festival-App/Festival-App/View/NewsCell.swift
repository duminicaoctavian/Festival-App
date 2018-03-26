//
//  NewsCell.swift
//  Festival-App
//
//  Created by Duminica Octavian on 24/02/2018.
//  Copyright © 2018 Duminica Octavian. All rights reserved.
//

import UIKit

class NewsCell: UITableViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var webView: UIWebView!
    @IBOutlet weak var simpleTextLabel: UILabel!
    
    @IBOutlet weak var simpleDateLabel: UILabel!
    @IBOutlet weak var simpleTitleLabel: UILabel!
    @IBOutlet weak var newsTextLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configureCell(news: News) {
        
        if (news.url != "none") {
            titleLabel.isHidden = false;
            dateLabel.isHidden = false;
            newsTextLabel.isHidden = false;
            webView.isHidden = false;
            
            webView.delegate = self
            
            
            let videoId = getYoutubeId(youtubeUrl: news.url)
            let urlString = "http://www.youtube.com/embed/\(videoId!)"
            let url = URL(string: urlString)
            let request = URLRequest(url: url!)
            webView.loadRequest(request)
            
            titleLabel.text = news.title
            newsTextLabel.text = news.description
            
            guard var isoDate = news.date else { return }
            let end = isoDate.index(isoDate.endIndex, offsetBy: -5)
            isoDate = String(isoDate[..<end])
            
            let isoFormatter = ISO8601DateFormatter()
            let chatDate = isoFormatter.date(from: isoDate.appending("Z"))
            
            let newFormatter = DateFormatter()
            newFormatter.dateFormat = "dd.MM.YYYY hh:mm"
            
            if let finalDate = chatDate {
                let finalDate = newFormatter.string(from: finalDate)
                dateLabel.text = finalDate
            }
        } else {
            simpleDateLabel.isHidden = false;
            simpleTextLabel.isHidden = false;
            simpleTitleLabel.isHidden = false;
            
            simpleTitleLabel.text = news.title
            simpleTextLabel.text = news.description;
            
            guard var isoDate = news.date else { return }
            let end = isoDate.index(isoDate.endIndex, offsetBy: -5)
            isoDate = String(isoDate[..<end])
            
            let isoFormatter = ISO8601DateFormatter()
            let chatDate = isoFormatter.date(from: isoDate.appending("Z"))
            
            let newFormatter = DateFormatter()
            newFormatter.dateFormat = "dd.MM.YYYY hh:mm"
            
            if let finalDate = chatDate {
                let finalDate = newFormatter.string(from: finalDate)
                simpleDateLabel.text = finalDate
            }
        }
        
    }
    
    func getVideo(url: String, completion: @escaping CompletionHandler) {
        
    }
    
    func getYoutubeId(youtubeUrl: String) -> String? {
        return URLComponents(string: youtubeUrl)?.queryItems?.first(where: { $0.name == "v" })?.value
    }
}

extension NewsCell: UIWebViewDelegate {
    func webViewDidFinishLoad(_ webView: UIWebView) {
        
    }
}

