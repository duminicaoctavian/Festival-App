//
//  UserMenuVC.swift
//  Festival-App
//
//  Created by Duminica Octavian on 21/02/2018.
//  Copyright © 2018 Duminica Octavian. All rights reserved.
//

import UIKit

enum UserMenuOption: String {
    case home = "Home"
    case news = "News"
    case artists = "Artists"
    case lineup = "Lineup"
    case accommodation = "Accommodation"
    case merch = "Merch"
    
    static func getRawValues() -> [String] {
        let options: [UserMenuOption] = [.home, .news, .artists, .lineup, .accommodation, .merch]
        var rawValues = [String]()
        options.forEach { (option) in
            rawValues.append(option.rawValue)
        }
        return rawValues
    }
}

class UserMenuVC: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var userBtn: UIButton!
    @IBOutlet weak var profileImgView: CircleImage!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setSWRevealViewControllerTrailingSpace()
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
        profileImgView.isUserInteractionEnabled = true
        profileImgView.addGestureRecognizer(tapGestureRecognizer)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        profileImgView.loadImageUsingCache(withURLString: AuthService.instance.user.imageURL)
    }
    
    @objc func imageTapped(tapGestureRecognizer: UITapGestureRecognizer) {
        let profileVC = storyboard?.instantiateViewController(withIdentifier: "ProfileVC") as! UINavigationController
        self.revealViewController().pushFrontViewController(profileVC, animated: true)
    }
    
    func setSWRevealViewControllerTrailingSpace() {
        self.revealViewController().rearViewRevealWidth = self.view.frame.size.width - 60
    }
    
    @IBAction func onUserButtonPressed(_ sender: Any) {
        AuthService.instance.logoutUser { (success) in
            if success {
                self.performSegue(withIdentifier: Segue.logout, sender: self)
            }
        }
    }
}

extension UserMenuVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return UserMenuOption.getRawValues().count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: UserMenuOption.getRawValues()[indexPath.row], for: indexPath) as? UserMenuCell {
            let option = UserMenuOption.getRawValues()[indexPath.row]
            cell.configureCell(optionName: option)
            return cell
        } else {
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let modelName = UIDevice.current.modelName
        if modelName == "iPhone 5s" || modelName == "iPhone SE" {
            return UIScreen.main.bounds.size.height/10;
        }
        return UIScreen.main.bounds.size.height/9;
    }
}
