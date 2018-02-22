//
//  UserMenuVC.swift
//  Festival-App
//
//  Created by Duminica Octavian on 21/02/2018.
//  Copyright © 2018 Duminica Octavian. All rights reserved.
//

import UIKit

class UserMenuVC: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setSWRevealViewControllerTrailingSpace()
    }
    
    func setSWRevealViewControllerTrailingSpace() {
        self.revealViewController().rearViewRevealWidth = self.view.frame.size.width - 60
    }
}

extension UserMenuVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return USER_MENU_OPTIONS.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: USER_MENU_OPTIONS[indexPath.row], for: indexPath) as? UserMenuCell {
            let option = USER_MENU_OPTIONS[indexPath.row]
            cell.configureCell(optionName: option)
            return cell
        } else {
            return UITableViewCell()
        }
    }
}
