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
    
    var selectedOption: Stage = .main

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var menuButton: UIButton!
    @IBOutlet weak var mainButton: UIButton!
    @IBOutlet weak var resistanceButton: UIButton!
    @IBOutlet weak var liveButton: UIButton!
    @IBOutlet weak var oasisButton: UIButton!
    @IBOutlet weak var mainLabel: UILabel!
    @IBOutlet weak var resistanceLabel: UILabel!
    @IBOutlet weak var liveLabel: UILabel!
    @IBOutlet weak var oasisLabel: UILabel!
    @IBOutlet weak var gradientView: GradientView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSlideMenu()
        highlightItem(button: mainButton, label: mainLabel)
        presenter.viewDidLoad()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        presenter.viewWillDisappear()
    }
    
    @objc func onDetailsTapped(sender: UIButton) {
        navigateToArtistDetailsScreen(fromIndex: sender.tag)
    }
    
    @IBAction func onStageButtonTapped(_ sender: UIButton) {
        switch sender.tag {
        case 0:
            presenter.loadArtists(forStage: .main)
            highlightItem(button: mainButton, label: mainLabel)
            unHighlightItems(buttons: [resistanceButton, liveButton, oasisButton],
                             labels: [resistanceLabel, liveLabel, oasisLabel])
            gradientView.bottomColor = UIColor.backgroundBlue
        case 1:
            presenter.loadArtists(forStage: .resistance)
            highlightItem(button: resistanceButton, label: resistanceLabel)
            unHighlightItems(buttons: [mainButton, liveButton, oasisButton],
                             labels: [mainLabel, liveLabel, oasisLabel])
            gradientView.bottomColor = UIColor.backgroundRed
        case 2:
            presenter.loadArtists(forStage: .live)
            highlightItem(button: liveButton, label: liveLabel)
            unHighlightItems(buttons: [mainButton, resistanceButton, oasisButton],
                             labels: [mainLabel, resistanceLabel, oasisLabel])
            gradientView.bottomColor = UIColor.backgroundYellow
        case 3:
            presenter.loadArtists(forStage: .oasis)
            highlightItem(button: oasisButton, label: oasisLabel)
            unHighlightItems(buttons: [mainButton, resistanceButton, liveButton],
                             labels: [mainLabel, resistanceLabel, liveLabel])
            gradientView.bottomColor = UIColor.backgroundGreen
        default:
            presenter.loadArtists(forStage: .main)
            highlightItem(button: mainButton, label: mainLabel)
            unHighlightItems(buttons: [resistanceButton, liveButton, oasisButton],
                             labels: [resistanceLabel, liveLabel, oasisLabel])
            gradientView.bottomColor = UIColor.backgroundBlue
        }
    }
}

extension ArtistsViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.artistsCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ArtistCell.className, for: indexPath) as? ArtistCell else {
            return UITableViewCell() }
        cell.detailsButton.tag = indexPath.row
        cell.detailsButton.addTarget(self, action: #selector(onDetailsTapped(sender:)), for: .touchUpInside)
        
        presenter.configure(cell, at: indexPath.row)
        
        return cell
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
        DispatchQueue.main.async { [weak self] in
            guard let weakSelf = self else { return }
            weakSelf.tableView.reloadData()
        }
    }
    
    func navigateToArtistDetailsScreen(fromIndex index: Int) {
        let detailsViewController = ArtistDetailsViewController()
        let detailsPresenter = detailsViewController.presenter
        presenter.handleDetailsTapped(forIndex: index, withPresenter: detailsPresenter)
        detailsViewController.modalPresentationStyle = .custom
        present(detailsViewController, animated: true, completion: nil)
    }
    
    func highlightItem(button: Highlightable, label: Highlightable) {
        button.highlight()
        label.highlight()
    }
    
    func unHighlightItems(buttons: [Highlightable], labels: [Highlightable]) {
        buttons.forEach { (button) in
            button.unHighlight()
        }
        labels.forEach { (label) in
            label.unHighlight()
        }
    }
}

