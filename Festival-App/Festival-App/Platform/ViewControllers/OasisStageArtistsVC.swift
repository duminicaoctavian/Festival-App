//
//  OasisStageArtistsVC.swift
//  Festival-App
//
//  Created by Duminica Octavian on 22/02/2018.
//  Copyright © 2018 Duminica Octavian. All rights reserved.
//

import UIKit

class OasisStageArtistsVC: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var menuBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpSWRevealViewController()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        ArtistService.instance.clearArtists()
        startSpinner()
        ArtistService.instance.getAllArtists(forStage: Stage.oasis.rawValue) { (success) in
            self.stopSpinner()
            self.tableView.reloadData()
        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        ArtistService.instance.clearArtists()
        tableView.reloadData()
    }
    
    func startSpinner() {
        LoadingView.startLoading()
    }
    
    func stopSpinner() {
        LoadingView.stopLoading()
    }
    
    func setUpSWRevealViewController() {
        menuBtn.addTarget(self.revealViewController(), action: #selector(SWRevealViewController.revealToggle(_:)), for: .touchUpInside)
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        self.view.addGestureRecognizer(self.revealViewController().tapGestureRecognizer())
    }
}

extension OasisStageArtistsVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ArtistService.instance.artists.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: ArtistCell.identifier, for: indexPath) as? ArtistCell {
//            let artist = ArtistService.instance.artists[indexPath.row]
//            cell.configureCell(artist: artist)
//            cell.didRequestToShowDetails = { (cell) in
//                let detailsVC = ArtistDetailsViewController()
//                detailsVC.presenter.nameChanged(artist.name)
//                detailsVC.presenter.genreChanged(artist.genre)
//                detailsVC.presenter.descriptionChanged(artist.description)
//                detailsVC.presenter.imageURLChanged(artist.artistImageURL)
//                detailsVC.modalPresentationStyle = .custom
//                self.present(detailsVC, animated: true, completion: nil)
//            }
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
