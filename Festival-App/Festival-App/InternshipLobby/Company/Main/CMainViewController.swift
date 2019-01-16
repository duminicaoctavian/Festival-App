//
//  CMainViewController.swift
//  Festival-App
//
//  Created by Octavian Duminica on 15/01/2019.
//  Copyright © 2019 Duminica Octavian. All rights reserved.
//

import UIKit

class CMainViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    lazy var visualEffectView: UIVisualEffectView = {
        let blurEffect = UIBlurEffect(style: .light)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = view.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        return blurEffectView
    }()
    
    lazy var presenter: CMainPresenter = {
        return CMainPresenter(view: self)
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter.loadOffers()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        presenter.removeOffers()
        super.viewWillDisappear(animated)
    }
}

extension CMainViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.numbersOfPendingOffers
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifier.pendingOfferCell, for: indexPath) as? CPendingOfferTableViewCell else { return UITableViewCell() }
        
        presenter.configure(cell, at: indexPath.row)
        
        return cell
    }
}

extension CMainViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension CMainViewController: CMainView {
    func displayAlert(title: String, message: String) {
        alert(title: title, message: message)
    }
    
    func startActivityIndicator() {
        view.addSubview(visualEffectView)
        LoadingView.startLoading()
    }
    
    func stopActivityIndicator() {
        visualEffectView.removeFromSuperview()
        LoadingView.stopLoading()
    }
    
    func reloadData() {
        tableView.reloadData()
    }
}
