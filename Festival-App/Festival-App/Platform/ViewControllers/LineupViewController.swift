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
    
    let imageCache = NSCache<AnyObject, AnyObject>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSlideMenu()
        hideNavigationBar()
        manageHighlightForItems(highlight: mainButton, unhighlight: [resistanceButton, liveButton, oasisButton])
        manageHighlightForItems(highlight: dayOneButton, unhighlight: [dayTwoButton, dayThreeButton, dayFourButton])
        presenter.viewDidLoad()
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
        guard let sectionData = presenter.data[presenter.selectedDay] else {
            return 0
        }
        return sectionData.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: LineupCell.className, for: indexPath) as! LineupCell
        
        // Configure the cell...
        guard let sectionData = presenter.data[presenter.selectedDay] else {
            return cell
        }
        
        let (timelinePoint, timelineBackColor, title, description, imageLink) = sectionData[indexPath.row]
        var timelineFrontColor = UIColor.clear
        if (indexPath.row > 0) {
            timelineFrontColor = sectionData[indexPath.row - 1].1
        }
        cell.timelinePoint = timelinePoint
        cell.timeline.frontColor = timelineFrontColor
        cell.timeline.backColor = timelineBackColor
        
        var isoDate = title
        let end = isoDate.index(isoDate.endIndex, offsetBy: -5)
        isoDate = String(isoDate[..<end])
        
        let isoFormatter = ISO8601DateFormatter()
        let chatDate = isoFormatter.date(from: isoDate.appending("Z"))
        
        let newFormatter = DateFormatter()
        newFormatter.dateFormat = "HH:mm"
        
        if let finalDate = chatDate {
            let finalDate = newFormatter.string(from: finalDate)
            cell.timestampLabel.text = finalDate
        }

        cell.artistNameLabel.text = description
        
        let imageUrl = URL(string: imageLink)!
        
        cell.artistImageView.image = nil
        
        if let imageFromCache = imageCache.object(forKey: imageLink as AnyObject) as? UIImage {
            cell.artistImageView.image = imageFromCache
            return cell
        }
        
        // Start background thread so that image loading does not make app unresponsive
        DispatchQueue.global(qos: .userInitiated).async {
        
            let imageData = NSData(contentsOf: imageUrl)!
        
            // When from background thread, UI needs to be updated on main_queue
            DispatchQueue.main.async {
                let imageToCache = UIImage(data: imageData as Data)
                
                self.imageCache.setObject(imageToCache!, forKey: imageLink as AnyObject)
                
                cell.artistImageView.image = imageToCache
            }
        }
        
        cell.didRequestToAddToOwnTimeline = { (cell) in
            print(description)
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
