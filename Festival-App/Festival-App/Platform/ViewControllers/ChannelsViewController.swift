//
//  ChannelsViewController.swift
//  Festival-App
//
//  Created by Duminica Octavian on 18/03/2018.
//  Copyright © 2018 Duminica Octavian. All rights reserved.
//

import UIKit

private struct Constants {
    static let slideMenuLeadingSpace: CGFloat = 60.0
}

class ChannelsViewController: UIViewController {
    
    lazy var presenter: ChannelsPresenter = {
        return ChannelsPresenter(view: self)
    }()

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSlideMenu()
        presenter.viewDidLoad()
    }
}

extension ChannelsViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.numberOfChannels
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ChannelCell.className, for: indexPath) as? ChannelCell else {
            return UITableViewCell()
        }
        
        presenter.configure(cell, at: indexPath.row)
        
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter.handleChannelSelection(at: indexPath.row)
        
        tableView.reloadRows(at: [indexPath], with: .none)
        tableView.selectRow(at: indexPath, animated: false, scrollPosition: .none)
        
        presenter.delegate?.channelSelected()
        
        navigateToChatLogScreen()
    }
}

extension ChannelsViewController: ChannelsView {
    func navigateToChatLogScreen() {
        revealViewController().revealToggle(animated: true)
    }
    
    func reloadData() {
        tableView.reloadData()
    }
    
    func setupSlideMenu() {
        revealViewController().rearViewRevealWidth = view.frame.size.width - Constants.slideMenuLeadingSpace
    }
}
