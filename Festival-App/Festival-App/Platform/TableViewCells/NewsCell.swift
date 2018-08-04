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
    @IBOutlet weak var webView: UIWebView!
    @IBOutlet weak var simpleTextLabel: UILabel!
    
    @IBOutlet weak var simpleDateLabel: UILabel!
    @IBOutlet weak var simpleTitleLabel: UILabel!
    @IBOutlet weak var newsTextLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        webView.delegate = self
    }
    
    func configureCell(news: News) {
        
        if (news.url != "none") {
            
            DispatchQueue.main.async {
                self.titleLabel.isHidden = false;
                self.dateLabel.isHidden = false;
                self.newsTextLabel.isHidden = false;
                self.webView.isHidden = false;    
                
                let videoId = self.getYoutubeId(youtubeUrl: news.url)
                let urlString = "http://www.youtube.com/embed/\(videoId!)"
                let url = URL(string: urlString)
                let request = URLRequest(url: url!)
                self.webView.loadRequest(request)
                
                self.titleLabel.text = news.title
                self.newsTextLabel.text = news.description
                
                guard var isoDate = news.date else { return }
                let end = isoDate.index(isoDate.endIndex, offsetBy: -5)
                isoDate = String(isoDate[..<end])
                
                let isoFormatter = ISO8601DateFormatter()
                let chatDate = isoFormatter.date(from: isoDate.appending("Z"))
                
                let newFormatter = DateFormatter()
                newFormatter.dateFormat = "dd.MM.YYYY hh:mm"
                
                if let finalDate = chatDate {
                    let finalDate = newFormatter.string(from: finalDate)
                    self.dateLabel.text = finalDate
                }
            }
        } else {
            DispatchQueue.main.async {
                
                self.simpleDateLabel.isHidden = false;
                self.simpleTextLabel.isHidden = false;
                
                self.simpleTitleLabel.isHidden = false;
                
                self.simpleTitleLabel.text = news.title
                self.simpleTextLabel.text = news.description;
                
                guard var isoDate = news.date else { return }
                let end = isoDate.index(isoDate.endIndex, offsetBy: -5)
                isoDate = String(isoDate[..<end])
                
                let isoFormatter = ISO8601DateFormatter()
                let chatDate = isoFormatter.date(from: isoDate.appending("Z"))
                
                let newFormatter = DateFormatter()
                newFormatter.dateFormat = "dd.MM.YYYY hh:mm"
                
                if let finalDate = chatDate {
                    let finalDate = newFormatter.string(from: finalDate)
                    self.simpleDateLabel.text = finalDate
                }
            }
        }
    }
    
    func getYoutubeId(youtubeUrl: String) -> String? {
        return URLComponents(string: youtubeUrl)?.queryItems?.first(where: { $0.name == "v" })?.value
    }
}

extension NewsCell: UIWebViewDelegate {
    func webViewDidFinishLoad(_ webView: UIWebView) {
        
        if (webView.isLoading) {
            return
        } else if (NewsService.instance.loaded == false){
            NewsService.instance.count = NewsService.instance.count + 1
            print(NewsService.instance.count)
        }
        
        NotificationCenter.default.post(name: NOTIF_WEBVIEWS_LOADED, object: nil)
    }
}

