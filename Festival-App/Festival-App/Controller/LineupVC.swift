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
    
    let data:[Int: [(TimelinePoint, UIColor, String, String, String?, String?, String?)]] = [0:[
        (TimelinePoint(), UIColor.lightGray, "12:30", "Borgore", nil, nil, nil),
        (TimelinePoint(), UIColor.lightGray, "15:30", "Noisia", nil, nil, nil),
        (TimelinePoint(), UIColor.green, "16:30", "Carl Cox", nil, nil, nil),
        (TimelinePoint(), UIColor.lightGray, "19:00", "Getter", nil, nil, nil),
        (TimelinePoint(), UIColor.lightGray, "20:00", "Skrillex", nil, nil, nil),
        (TimelinePoint(), UIColor.clear, "21:00", "Steve Aoki", nil, nil, nil)
        ], 1:[
            (TimelinePoint(), UIColor.lightGray, "08:30", "Dua Lipa", nil, nil, nil),
            (TimelinePoint(), UIColor.lightGray, "09:30", "David Guetta", nil, nil, nil),
            (TimelinePoint(), UIColor.lightGray, "10:00", "Avicii", nil, nil, nil),
            (TimelinePoint(), UIColor.lightGray, "11:30", "Eptic", nil, nil, nil),
            (TimelinePoint(), UIColor.lightGray, "12:30", "Nina Kraviz", nil, nil, nil),
            (TimelinePoint(), UIColor.lightGray, "13:00", "Solomun", nil, nil, nil),
            (TimelinePoint(), UIColor.lightGray, "15:00", "Pendulum", nil, nil, nil),
            (TimelinePoint(), UIColor.lightGray, "17:30", "The Prodigy", nil, nil, nil),
            (TimelinePoint(), UIColor.lightGray, "18:30", "Rita Ora", nil, nil, nil),
            (TimelinePoint(), UIColor.lightGray, "19:30", "Modestep", nil, nil, nil),
            (TimelinePoint(), backColor: UIColor.clear, "20:00", "Martin Garrix", nil, nil, nil)
        ]]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpSWRevealViewController()
        
        let timelineTableViewCellNib = UINib(nibName: "TimelineTableViewCell", bundle: Bundle(for: TimelineTableViewCell.self))
        self.tableView.register(timelineTableViewCellNib, forCellReuseIdentifier: "TimelineTableViewCell")
    }
    
    func setUpSWRevealViewController() {
        menuBtn.addTarget(self.revealViewController(), action: #selector(SWRevealViewController.revealToggle(_:)), for: .touchUpInside)
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        self.view.addGestureRecognizer(self.revealViewController().tapGestureRecognizer())
    }
}

extension LineupVC: UITableViewDataSource, UITableViewDelegate {
   
    func numberOfSections(in tableView: UITableView) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let sectionData = data[section] else {
            return 0
        }
        return sectionData.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TimelineTableViewCell", for: indexPath) as! TimelineTableViewCell
        
        // Configure the cell...
        guard let sectionData = data[indexPath.section] else {
            return cell
        }
        
        let (timelinePoint, timelineBackColor, title, description, _, _, _) = sectionData[indexPath.row]
        var timelineFrontColor = UIColor.clear
        if (indexPath.row > 0) {
            timelineFrontColor = sectionData[indexPath.row - 1].1
        }
        cell.timelinePoint = timelinePoint
        cell.timeline.frontColor = timelineFrontColor
        cell.timeline.backColor = timelineBackColor
        cell.titleLabel.text = title
        cell.descriptionLabel.text = description
        cell.illustrationImageView.image = UIImage(named: description)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let sectionData = data[indexPath.section] else {
            return
        }
        
        print(sectionData[indexPath.row])
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView?
    {
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.bounds.size.width, height: 30))
        headerView.backgroundColor = #colorLiteral(red: 0.2196078431, green: 0.07843137255, blue: 0.3725490196, alpha: 1)
        let titleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 100, height: 20))
        titleLabel.text = "Day " + String(describing: section + 1)
        titleLabel.textColor = UIColor.white
        titleLabel.textAlignment = .center
        titleLabel.center = headerView.center
        headerView.addSubview(titleLabel)
        return headerView
    }
    
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.layer.transform = CATransform3DMakeScale(0.95, 0.95, 1)
        
        UIView.animate(withDuration: 0.3, animations: {
            cell.layer.transform = CATransform3DMakeScale(1.0, 1.0, 1.0)
        }, completion: nil)
    }
}
