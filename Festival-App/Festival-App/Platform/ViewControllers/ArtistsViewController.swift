//
//  ArtistsViewController.swift
//  Festival-App
//
//  Created by Duminica Octavian on 22/02/2018.
//  Copyright © 2018 Duminica Octavian. All rights reserved.
//

import UIKit

class ArtistsViewController: UIViewController {
    
    lazy var presenter: ArtistsPresenter = {
        return ArtistsPresenter(view: self)
    }()

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var menuButton: UIButton!
    
    lazy var visualEffectView: UIVisualEffectView = {
        let blurEffect = UIBlurEffect(style: .dark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = self.view.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        return blurEffectView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSlideMenu()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter.viewWillAppear()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        presenter.viewWillDisappear()
    }
    
    @objc func onDetailsTapped(sender: UIButton) {
        navigateToArtistDetailsScreen(fromIndex: sender.tag)
    }
}

extension ArtistsViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // TODO - move to presenter
        return ArtistService.instance.artists.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ArtistCell.identifier, for: indexPath) as? ArtistCell else {
            return UITableViewCell() }
        cell.detailsButton.tag = indexPath.row
        cell.detailsButton.addTarget(self, action: #selector(onDetailsTapped(sender:)), for: .touchUpInside)
        
        presenter.configure(cell, at: indexPath.row)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.layer.transform = CATransform3DMakeScale(0.95, 0.95, 1)
        
        UIView.animate(withDuration: 0.3, animations: {
            cell.layer.transform = CATransform3DMakeScale(1.0, 1.0, 1.0)
        }, completion: nil)
    }
}

extension ArtistsViewController: ArtistsView {
    func startActivityIndicator() {
        LoadingView.startLoading()
    }
    
    func stopActivityIndicator() {
        LoadingView.stopLoading()
    }
    
    func setupSlideMenu() {
        menuButton.addTarget(revealViewController(), action: #selector(SWRevealViewController.revealToggle(_:)), for: .touchUpInside)
        view.addGestureRecognizer(revealViewController().panGestureRecognizer())
        view.addGestureRecognizer(revealViewController().tapGestureRecognizer())
    }
    
    func reloadData() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func navigateToArtistDetailsScreen(fromIndex index: Int) {
        let detailsViewController = ArtistDetailsViewController()
        let detailsPresenter = detailsViewController.presenter
        presenter.handleDetailsTapped(forIndex: index, withPresenter: detailsPresenter)
        detailsViewController.modalPresentationStyle = .custom
        present(detailsViewController, animated: true, completion: nil)
    }
}

