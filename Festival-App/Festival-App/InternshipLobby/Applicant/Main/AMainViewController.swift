//
//  AMainViewController.swift
//  Festival-App
//
//  Created by Octavian Duminica on 15/01/2019.
//  Copyright © 2019 Duminica Octavian. All rights reserved.
//

import UIKit

class AMainViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var offerSegmentedControl: UISegmentedControl!
    
    lazy var presenter: AMainPresenter = {
        return AMainPresenter(view: self)
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
    
    @IBAction func segmentedControlValueChanged(_ sender: UISegmentedControl) {
        
    }
}

extension AMainViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.numberOfOffers
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifier.offerCell, for: indexPath) as? AOfferTableViewCell else { return UITableViewCell() }
        
        presenter.configure(cell, at: indexPath.row)
        
        return cell
    }
}

extension AMainViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        presenter.didSelectRow(at: indexPath.row)
    }
}

extension AMainViewController: AMainView {
    
    func reloadData() {
        tableView.reloadData()
    }
    
    func navigateToDetails(at index: Int) {
        guard let details = storyboard?.instantiateViewController(withIdentifier: Storyboard.ADetailViewController) as? ADetailsViewController else { return }
        details.presenter.setOffer(OfferService.shared.offers[index])
        navigationController?.pushViewController(details, animated: true)
    }
}
