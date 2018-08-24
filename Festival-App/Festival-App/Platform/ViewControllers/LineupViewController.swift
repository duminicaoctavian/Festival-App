//
//  LineupVC.swift
//  Festival-App
//
//  Created by Duminica Octavian on 24/02/2018.
//  Copyright © 2018 Duminica Octavian. All rights reserved.
//

import UIKit

class LineupViewController: UIViewController {

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
    
    var data = [Int: [(TimelinePoint, UIColor, String, String, String)]]()
    var day: Int!
    var stage: String!
    var imageUrlString: String?
    
    let imageCache = NSCache<AnyObject, AnyObject>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpSWRevealViewController()
        navigationController?.navigationBar.isHidden = true
        day = 1
        stage = "Main"
        highlightBtn(btn: mainButton)
        highlightBtn(btn: dayOneButton)
        
        getFilteredArtists(stage: stage, day: day)
    }
    
    func getFilteredArtists(stage: String, day: Int) {
        LoadingView.startLoading()
        ArtistService.shared.clearArtists()
        data.removeAll()
        tableView.reloadData()
        ArtistService.shared.getFilteredArtists(forStage: stage, and: day) { (success) in
            if (success) {
                print(ArtistService.shared.artists)
                for index in 0..<ArtistService.shared.artists.count {
                    let artist = ArtistService.shared.artists[index]
                    
                    if index == ArtistService.shared.artists.count - 1 {
                        self.data[Int(artist.day)]?.append((TimelinePoint(), backColor: UIColor.clear, artist.date, artist.name, artist.artistImageURL))
                        break
                    }
                    
                    let keyExists = self.data[Int(artist.day)] != nil
                    
                    if keyExists {
                        self.data[Int(artist.day)]?.append((TimelinePoint(), UIColor.lightGray, artist.date, artist.name, artist.artistImageURL))
                    } else {
                        self.data[Int(artist.day)] = [(TimelinePoint(), UIColor.lightGray, artist.date, artist.name, artist.artistImageURL)]
                    }
                    
                }
                LoadingView.stopLoading()
                self.tableView.reloadData()
            }
        }
    }
    
    
    func setUpSWRevealViewController() {
        menuButton.addTarget(self.revealViewController(), action: #selector(SWRevealViewController.revealToggle(_:)), for: .touchUpInside)
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        self.view.addGestureRecognizer(self.revealViewController().tapGestureRecognizer())
    }
    @IBAction func onMainStagePressed(_ sender: Any) {
        stage = "Main"
        getFilteredArtists(stage: stage, day: day)
        highlightBtn(btn: mainButton)
        unHighlightBtns(btn1: resistanceButton, btn2: liveButton, btn3: oasisButton)
    }
    @IBAction func onResistancePressed(_ sender: Any) {
        stage = "Resistance"
        getFilteredArtists(stage: stage, day: day)
        highlightBtn(btn: resistanceButton)
        unHighlightBtns(btn1: mainButton, btn2: liveButton, btn3: oasisButton)
    }
    @IBAction func onLivePressed(_ sender: Any) {
        stage = "Live"
        getFilteredArtists(stage: stage, day: day)
        highlightBtn(btn: liveButton)
        unHighlightBtns(btn1: mainButton, btn2: resistanceButton, btn3: oasisButton)
    }
    @IBAction func onOasisPressed(_ sender: Any) {
        stage = "Oasis"
        getFilteredArtists(stage: stage, day: day)
        highlightBtn(btn: oasisButton)
        unHighlightBtns(btn1: mainButton, btn2: resistanceButton, btn3: liveButton)
    }
    
    @IBAction func onDayOnePressed(_ sender: Any) {
        day = 1
        getFilteredArtists(stage: stage, day: day)
        highlightBtn(btn: dayOneButton)
        unHighlightBtns(btn1: dayTwoButton, btn2: dayThreeButton, btn3: dayFourButton)
    }
    @IBAction func onDayTwoPressed(_ sender: Any) {
        day = 2
        getFilteredArtists(stage: stage, day: day)
        highlightBtn(btn: dayTwoButton)
        unHighlightBtns(btn1: dayOneButton, btn2: dayThreeButton, btn3: dayFourButton)
    }
    
    @IBAction func onDayThreePressed(_ sender: Any) {
        day = 3
        getFilteredArtists(stage: stage, day: day)
        highlightBtn(btn: dayThreeButton)
        unHighlightBtns(btn1: dayOneButton, btn2: dayTwoButton, btn3: dayFourButton)
    }
    @IBAction func onDayFourPressed(_ sender: Any) {
        day = 4
        getFilteredArtists(stage: stage, day: day)
        highlightBtn(btn: dayFourButton)
        unHighlightBtns(btn1: dayOneButton, btn2: dayTwoButton, btn3: dayThreeButton)
    }
    
    func highlightBtn(btn: UIButton) {
        btn.alpha = 1.0
    }
    
    func unHighlightBtns(btn1: UIButton, btn2: UIButton, btn3: UIButton) {
        btn1.alpha = 0.3
        btn2.alpha = 0.3
        btn3.alpha = 0.3
    }
}

extension LineupViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let sectionData = data[day] else {
            return 0
        }
        return sectionData.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: LineupCell.className, for: indexPath) as! LineupCell
        
        // Configure the cell...
        guard let sectionData = data[day] else {
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let sectionData = data[indexPath.section] else {
            return
        }
        
        print(sectionData[indexPath.row])
    }
}
