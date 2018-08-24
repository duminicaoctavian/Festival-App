//
//  LineupVC.swift
//  Festival-App
//
//  Created by Duminica Octavian on 24/02/2018.
//  Copyright © 2018 Duminica Octavian. All rights reserved.
//

import UIKit

class LineupVC: UIViewController {

    @IBOutlet weak var menuBtn: UIButton!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var mainStageBtn: UIButton!
    @IBOutlet weak var resistanceStageBtn: UIButton!
    @IBOutlet weak var liveStageBtn: UIButton!
    @IBOutlet weak var oasisStageBtn: UIButton!
    @IBOutlet weak var dayOneBtn: UIButton!
    @IBOutlet weak var dayTwoBtn: UIButton!
    @IBOutlet weak var dayThreeBtn: UIButton!
    @IBOutlet weak var dayFourBtn: UIButton!
    
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
        highlightBtn(btn: mainStageBtn)
        highlightBtn(btn: dayOneBtn)
        
        let timelineTableViewCellNib = UINib(nibName: "TimelineTableViewCell", bundle: Bundle(for: TimelineTableViewCell.self))
        self.tableView.register(timelineTableViewCellNib, forCellReuseIdentifier: "TimelineTableViewCell")
        
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
        menuBtn.addTarget(self.revealViewController(), action: #selector(SWRevealViewController.revealToggle(_:)), for: .touchUpInside)
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        self.view.addGestureRecognizer(self.revealViewController().tapGestureRecognizer())
    }
    @IBAction func onMainStagePressed(_ sender: Any) {
        stage = "Main"
        getFilteredArtists(stage: stage, day: day)
        highlightBtn(btn: mainStageBtn)
        unHighlightBtns(btn1: resistanceStageBtn, btn2: liveStageBtn, btn3: oasisStageBtn)
    }
    @IBAction func onResistancePressed(_ sender: Any) {
        stage = "Resistance"
        getFilteredArtists(stage: stage, day: day)
        highlightBtn(btn: resistanceStageBtn)
        unHighlightBtns(btn1: mainStageBtn, btn2: liveStageBtn, btn3: oasisStageBtn)
    }
    @IBAction func onLivePressed(_ sender: Any) {
        stage = "Live"
        getFilteredArtists(stage: stage, day: day)
        highlightBtn(btn: liveStageBtn)
        unHighlightBtns(btn1: mainStageBtn, btn2: resistanceStageBtn, btn3: oasisStageBtn)
    }
    @IBAction func onOasisPressed(_ sender: Any) {
        stage = "Oasis"
        getFilteredArtists(stage: stage, day: day)
        highlightBtn(btn: oasisStageBtn)
        unHighlightBtns(btn1: mainStageBtn, btn2: resistanceStageBtn, btn3: liveStageBtn)
    }
    
    @IBAction func onDayOnePressed(_ sender: Any) {
        day = 1
        getFilteredArtists(stage: stage, day: day)
        highlightBtn(btn: dayOneBtn)
        unHighlightBtns(btn1: dayTwoBtn, btn2: dayThreeBtn, btn3: dayFourBtn)
    }
    @IBAction func onDayTwoPressed(_ sender: Any) {
        day = 2
        getFilteredArtists(stage: stage, day: day)
        highlightBtn(btn: dayTwoBtn)
        unHighlightBtns(btn1: dayOneBtn, btn2: dayThreeBtn, btn3: dayFourBtn)
    }
    
    @IBAction func onDayThreePressed(_ sender: Any) {
        day = 3
        getFilteredArtists(stage: stage, day: day)
        highlightBtn(btn: dayThreeBtn)
        unHighlightBtns(btn1: dayOneBtn, btn2: dayTwoBtn, btn3: dayFourBtn)
    }
    @IBAction func onDayFourPressed(_ sender: Any) {
        day = 4
        getFilteredArtists(stage: stage, day: day)
        highlightBtn(btn: dayFourBtn)
        unHighlightBtns(btn1: dayOneBtn, btn2: dayTwoBtn, btn3: dayThreeBtn)
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

extension LineupVC: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let sectionData = data[day] else {
            return 0
        }
        return sectionData.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TimelineTableViewCell", for: indexPath) as! TimelineTableViewCell
        
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
            cell.titleLabel.text = finalDate
        }

        cell.descriptionLabel.text = description
        
        let imageUrl = URL(string: imageLink)!
        
        cell.illustrationImageView.image = nil
        
        if let imageFromCache = imageCache.object(forKey: imageLink as AnyObject) as? UIImage {
            cell.illustrationImageView.image = imageFromCache
            return cell
        }
        
        // Start background thread so that image loading does not make app unresponsive
        DispatchQueue.global(qos: .userInitiated).async {
        
            let imageData = NSData(contentsOf: imageUrl)!
        
            // When from background thread, UI needs to be updated on main_queue
            DispatchQueue.main.async {
                let imageToCache = UIImage(data: imageData as Data)
                
                self.imageCache.setObject(imageToCache!, forKey: imageLink as AnyObject)
                
                cell.illustrationImageView.image = imageToCache
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
