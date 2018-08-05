//
//  NewsPresenter.swift
//  Festival-App
//
//  Created by Octavian Duminica on 05/08/2018.
//  Copyright © 2018 Duminica Octavian. All rights reserved.
//

import Foundation

class NewsPresenter {
    weak var view: NewsView?
    
    init(view: NewsView) {
        self.view = view
    }
    
    var newsCount: Int {
        get {
            return NewsService.instance.news.count
        }
    }
    
    func addObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(webViewsFinishedLoading(_:)), name: NotificationName.webViewsLoaded, object: nil)
    }
    
    @objc func webViewsFinishedLoading(_ notif: Notification) {
        view?.stopActivityIndicator()
        view?.showTableView()
        NewsService.instance.loaded = true
    }
    
    func viewWillAppear() {
        NewsService.instance.clearNews()
        
        view?.startActivityIndicator()
        NewsService.instance.findAllNews(completion: { [weak self] (success) in
            guard let weakSelf = self else { return }
            
            if (success) {
                weakSelf.view?.reloadData()
                NewsService.instance.loaded = false
            } else {
                // TODO
            }
        })
    }
    
    func viewWillDisappear() {
        NotificationCenter.default.removeObserver(self)
    }
    
    func handleItem(at index: Int) -> NewsCellType {
        let item = NewsService.instance.news[index]
        if let _ = item.imageURL {
            return .image
        }
        if let _ = item.videoURL {
            return .video
        }
        return .plain
    }
    
    func configure(_ itemView: VideoNewsItemView, at index: Int) {
        let news = NewsService.instance.news[index]
        itemView.displayTitle(news.title)
        itemView.displayNewsText(news.description)
        
        guard let date = news.date.convertFromISODate(toFormat: DateFormat.ddMMYYYYhhmm.rawValue) else { return }
        itemView.displayDate(date)
        
        guard let request = generateRequest(from: news.videoURL!) else { return }
        itemView.displayYoutubeThumbnail(request)
    }
    
    func configure(_ itemView: PictureNewsItemView, at index: Int) {
        let news = NewsService.instance.news[index]
        itemView.displayTitle(news.title)
        itemView.displayNewsText(news.description)
        
        guard let date = news.date.convertFromISODate(toFormat: DateFormat.ddMMYYYYhhmm.rawValue) else { return }
        itemView.displayDate(date)
        
        itemView.displayNewsImage(news.imageURL!)
    }
    
    func handleLoadingOfWebViews() {
        if NewsService.instance.loaded == false {
            NotificationCenter.default.post(name: NotificationName.webViewsLoaded, object: nil)
        }
    }
    
    private func generateRequest(from URLString: String) -> URLRequest? {
        guard let videoID = URLString.getYoutubeID() else { return nil }
        let URLString = "http://www.youtube.com/embed/\(videoID)"
        guard let URL = URL(string: URLString) else { return nil }
        return URLRequest(url: URL)
    }
}
