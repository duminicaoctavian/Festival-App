//
//  LineupVC.swift
//  Festival-App
//
//  Created by Duminica Octavian on 24/02/2018.
//  Copyright © 2018 Duminica Octavian. All rights reserved.
//

import UIKit

class LineupViewController: UIViewController {
    
    lazy var presenter: LineupPresenter = {
        return LineupPresenter(view: self)
    }()

    @IBOutlet weak var menuButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var mainButton: UIButton!
    @IBOutlet weak var resistanceButton: UIButton!
    @IBOutlet weak var liveButton: UIButton!
    @IBOutlet weak var oasisButton: UIButton!
    @IBOutlet weak var dayOneButton: UIButton!
    @IBOutlet weak var dayTwoButton: UIButton!
    @IBOutlet weak var dayThreeButton: UIButton!
    @IBOutlet weak var dayFourButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSlideMenu()
        hideNavigationBar()
        manageHighlightForItems(highlight: mainButton, unhighlight: [resistanceButton, liveButton, oasisButton])
        manageHighlightForItems(highlight: dayOneButton, unhighlight: [dayTwoButton, dayThreeButton, dayFourButton])
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter.viewWillAppear()
    }
    
    @IBAction func onDayTapped(_ sender: UIButton) {
        presenter.handleDayFilter(forSelection: sender.tag)
        switch sender.tag {
        case 1:
            manageHighlightForItems(highlight: dayOneButton, unhighlight: [dayTwoButton, dayThreeButton, dayFourButton])
        case 2:
            manageHighlightForItems(highlight: dayTwoButton, unhighlight: [dayOneButton, dayThreeButton, dayFourButton])
        case 3:
            manageHighlightForItems(highlight: dayThreeButton, unhighlight: [dayOneButton, dayTwoButton, dayFourButton])
        case 4:
            manageHighlightForItems(highlight: dayFourButton, unhighlight: [dayOneButton, dayTwoButton, dayThreeButton])
        default:
            manageHighlightForItems(highlight: dayOneButton, unhighlight: [dayTwoButton, dayThreeButton, dayFourButton])
        }
    }

    @IBAction func onStageTapped(_ sender: UIButton) {
        presenter.handleStageFilter(forSelection: sender.tag)
        switch sender.tag {
        case 0:
            manageHighlightForItems(highlight: mainButton, unhighlight: [resistanceButton, liveButton, oasisButton])
        case 1:
            manageHighlightForItems(highlight: resistanceButton, unhighlight: [mainButton, liveButton, oasisButton])
        case 2:
            manageHighlightForItems(highlight: liveButton, unhighlight: [mainButton, resistanceButton, oasisButton])
        case 3:
            manageHighlightForItems(highlight: oasisButton, unhighlight: [mainButton, resistanceButton, liveButton])
        default:
            manageHighlightForItems(highlight: mainButton, unhighlight: [resistanceButton, liveButton, oasisButton])
        }
    }
    
    private func manageHighlightForItems(highlight button: Highlightable, unhighlight buttons: [Highlightable]) {
        highlightItem(button: button)
        unHighlightItems(buttons: buttons)
    }
}

extension LineupViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.artistCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: LineupCell.className, for: indexPath) as? LineupCell else {
            return UITableViewCell()
        }
        
        presenter.configure(cell, at: indexPath.row)

        cell.didAddToOwnTimeline = { [weak self] in
            guard let weakSelf = self else { return }
            weakSelf.presenter.addArtistToUserTimeline(withIndex: indexPath.row)
        }
        
        return cell
    }
}

extension LineupViewController: LineupView {
    func setupSlideMenu() {
        menuButton.addTarget(revealViewController(), action: #selector(SWRevealViewController.revealToggle(_:)), for: .touchUpInside)
        view.addGestureRecognizer(revealViewController().panGestureRecognizer())
        view.addGestureRecognizer(revealViewController().tapGestureRecognizer())
    }
    
    func hideNavigationBar() {
        navigationController?.navigationBar.isHidden = true
    }
    
    func startActivityIndicator() {
        LoadingView.startLoading()
    }
    
    func stopActivityIndicator() {
        LoadingView.stopLoading()
    }
    
    func highlightItem(button: Highlightable) {
        button.highlight()
    }
    
    func unHighlightItems(buttons: [Highlightable]) {
        buttons.forEach { (button) in
            button.unHighlight()
        }
    }
    
    func reloadData() {
        tableView.reloadData()
    }
}
