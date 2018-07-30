//
//  NewsVC.swift
//  Festival-App
//
//  Created by Duminica Octavian on 19/03/2018.
//  Copyright © 2018 Duminica Octavian. All rights reserved.
//

import UIKit

class NewsVC: UIViewController {
    
    @IBOutlet weak var menuBtn: UIButton!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpSWRevealViewController()
        
        tableView.estimatedRowHeight = 250;
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.isHidden = true
        
        NotificationCenter.default.addObserver(self, selector: #selector(NewsVC.webViewsFinishedLoading(_:)), name: NOTIF_WEBVIEWS_LOADED, object: nil)
    }
    
    @objc func webViewsFinishedLoading(_ notif: Notification) {
        self.stopSpinner()
        self.tableView.isHidden = false
        NewsService.instance.loaded = true
    }
    
    func setUpSWRevealViewController() {
        menuBtn.addTarget(self.revealViewController(), action: #selector(SWRevealViewController.revealToggle(_:)), for: .touchUpInside)
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        self.view.addGestureRecognizer(self.revealViewController().tapGestureRecognizer())
    }
    
    override func viewWillAppear(_ animated: Bool) {
        NewsService.instance.clearNews()
        startSpinner()
        NewsService.instance.findAllNews(completion: { (success) in
            if (success) {
                self.tableView.reloadData()
                NewsService.instance.count = 0
                NewsService.instance.loaded = false
            }
        })
    }
    
    func startSpinner() {
        LoadingView.startLoading()
    }
    
    func stopSpinner() {
        LoadingView.stopLoading()
    }
}

extension NewsVC : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return NewsService.instance.news.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: NEWS_CELL_IDENTIFIER, for: indexPath) as? NewsCell {
            let news = NewsService.instance.news[indexPath.row]
            cell.configureCell(news: news)
            return cell
        } else {
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.layer.transform = CATransform3DMakeScale(0.95, 0.95, 1)
        
        UIView.animate(withDuration: 0.3, animations: {
            cell.layer.transform = CATransform3DMakeScale(1.0, 1.0, 1.0)
        }, completion: nil)
    }
}
