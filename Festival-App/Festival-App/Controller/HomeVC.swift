//
//  HomeVC.swift
//  Festival-App
//
//  Created by Duminica Octavian on 21/02/2018.
//  Copyright © 2018 Duminica Octavian. All rights reserved.
//

import UIKit

class HomeVC: UIViewController {
    
    // Outlets
    @IBOutlet weak var menuBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpSWRevealViewController()
        print(AuthService.instance.authToken)
    }
    
    func setUpSWRevealViewController() {
        menuBtn.addTarget(self.revealViewController(), action: #selector(SWRevealViewController.revealToggle(_:)), for: .touchUpInside)
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        self.view.addGestureRecognizer(self.revealViewController().tapGestureRecognizer())
    }
    
    @IBAction func onChatPressed(_ sender: Any) {
        performSegue(withIdentifier: TO_CHAT, sender: self)
    }
}
