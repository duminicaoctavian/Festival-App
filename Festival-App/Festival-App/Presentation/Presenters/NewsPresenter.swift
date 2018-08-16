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
    
    func addObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(webViewsFinishedLoading(_:)), name: NotificationName.webViewsLoaded, object: nil)
    }
    
    @objc func webViewsFinishedLoading(_ notif: Notification) {
        view?.stopActivityIndicator()
        view?.showTableView()
        NewsService.shared.loaded = true
    }
    
    func viewWillAppear() {
        NewsService.shared.clearNews()
        
        view?.startActivityIndicator()
        NewsService.shared.findAllNews(completion: { [weak self] (success) in
            guard let _ = self else { return }
            
            if (success) {
                DispatchQueue.main.async { [weak self] in
                    guard let weakSelf = self else { return }
                    weakSelf.view?.reloadData()
                }
                NewsService.shared.loaded = false
            } else {
                // TODO
            }
        })
    }
    
    func viewWillDisappear() {
        NotificationCenter.default.removeObserver(self)
    }
    
    func handleLoadingOfWebViews() {
        if NewsService.shared.loaded == false {
            NotificationCenter.default.post(name: NotificationName.webViewsLoaded, object: nil)
        }
    }
}
