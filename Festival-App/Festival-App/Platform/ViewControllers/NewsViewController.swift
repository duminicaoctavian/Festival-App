//
//  NewsViewController.swift
//  Festival-App
//
//  Created by Duminica Octavian on 19/03/2018.
//  Copyright © 2018 Duminica Octavian. All rights reserved.
//

import UIKit

enum NewsCellType {
    case video
    case image
    case plain
}

private struct Constants {
    static let tableViewEstimatedRowHeight: CGFloat = 250.0
}

class NewsViewController: UIViewController {
    
    lazy var presenter: NewsPresenter = {
        return NewsPresenter(view: self)
    }()
    
    @IBOutlet weak var menuButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSlideMenu()
        hideTableView()
        setupTableViewAutomaticCellDimension()
        
        presenter.addObservers()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter.viewWillAppear()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        presenter.viewWillDisappear()
    }
}

extension NewsViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.newsCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellType = presenter.handleItem(at: indexPath.row)
        
        switch cellType {
        case .image:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: PictureNewsCell.identifier, for: indexPath) as? PictureNewsCell else { return UITableViewCell() }
            
            presenter.configure(cell, at: indexPath.row)
            return cell
            
        case .video:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: VideoNewsCell.identifier, for: indexPath) as? VideoNewsCell else { return UITableViewCell() }
            
            presenter.configure(cell, at: indexPath.row)
            return cell
            
        case .plain:
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.layer.transform = CATransform3DMakeScale(AnimationParameter.xStartScale,
                                                      AnimationParameter.yStartScale,
                                                      AnimationParameter.zStartScale)
        
        UIView.animate(withDuration: AnimationParameter.duration, animations: {
            cell.layer.transform = CATransform3DMakeScale(AnimationParameter.xEndScale,
                                                          AnimationParameter.yEndScale,
                                                          AnimationParameter.zEndScale)
        }, completion: nil)
    }
}

extension NewsViewController: NewsView {
    func setupTableViewAutomaticCellDimension() {
        tableView.estimatedRowHeight = Constants.tableViewEstimatedRowHeight
        tableView.rowHeight = UITableViewAutomaticDimension
    }
    
    func showTableView() {
        tableView.isHidden = false
    }
    
    func hideTableView() {
        tableView.isHidden = true
    }
    
    func setupSlideMenu() {
        menuButton.addTarget(revealViewController(), action: #selector(SWRevealViewController.revealToggle(_:)), for: .touchUpInside)
        view.addGestureRecognizer(revealViewController().panGestureRecognizer())
        view.addGestureRecognizer(revealViewController().tapGestureRecognizer())
    }
    
    func startActivityIndicator() {
        LoadingView.startLoading()
    }
    
    func stopActivityIndicator() {
        LoadingView.stopLoading()
    }
    
    func reloadData() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}

extension NewsViewController: UIWebViewDelegate {
    func webViewDidFinishLoad(_ webView: UIWebView) {
        
        if (webView.isLoading) {
            return
        } else {
            presenter.handleLoadingOfWebViews()
        }
    }
}
