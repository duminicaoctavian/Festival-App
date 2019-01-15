//
//  MyOffersViewController.swift
//  Festival-App
//
//  Created by Octavian Duminica on 05/09/2018.
//  Copyright © 2018 Duminica Octavian. All rights reserved.
//

import Foundation

class MyOffersViewController: UIViewController {
    
    lazy var presenter: MyOfferPresenter = {
        return MyOfferPresenter(view: self)
    }()
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad()
    }
    
    @IBAction func onBackTapped(_ sender: Any) {
        navigateToProfileScreen()
    }
}

extension MyOffersViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.locationsCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: OfferCell.className, for: indexPath) as? OfferCell else { return UITableViewCell() }
        
        presenter.configure(cell, at: indexPath.row)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        navigateToOfferLocationDetailsScreen(from: indexPath.row)
    }
}

extension MyOffersViewController: MyOfferView {
    func startActivityIndicator() {
        LoadingView.startLoading()
    }
    
    func stopActivityIndicator() {
        LoadingView.stopLoading()
    }
    
    func navigateToOfferLocationDetailsScreen(from index: Int) {
        let locationDetailsViewController = LocationDetailsViewController()
        locationDetailsViewController.presenter.locationChanged(presenter.getLocationAtIndex(index))
        navigationController?.pushViewController(locationDetailsViewController, animated: true)
    }
    
    func reloadData() {
        tableView.reloadData()
    }
    
    func navigateToProfileScreen() {
        navigationController?.popViewController(animated: true)
    }
}
