//
//  NewsViewController.swift
//  Festival-App
//
//  Created by Duminica Octavian on 19/03/2018.
//  Copyright © 2018 Duminica Octavian. All rights reserved.
//

import UIKit

private struct Constants {
    static let tableViewEstimatedRowHeight: CGFloat = 250.0
}

class NewsViewController: UIViewController {
    
    lazy var presenter: NewsPresenter = {
        return NewsPresenter(view: self)
    }()
    
    lazy var viewModel: NewsViewModel = {
        return NewsViewModel()
    }()
    
    @IBOutlet weak var menuButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = viewModel
        setupSlideMenu()
        hideTableView()
        setupTableViewAutomaticCellDimension()
        
        presenter.addObservers()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        showStatusBar()
        presenter.viewWillAppear()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        presenter.viewWillDisappear()
    }
}

extension NewsViewController : UITableViewDelegate {
    
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
        tableView.reloadData()
    }
    
    func showStatusBar() {
        UIApplication.shared.isStatusBarHidden = false
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
