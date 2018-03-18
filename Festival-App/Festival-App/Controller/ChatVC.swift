//
//  ChatVC.swift
//  Festival-App
//
//  Created by Duminica Octavian on 18/03/2018.
//  Copyright © 2018 Duminica Octavian. All rights reserved.
//

import UIKit

class ChatVC: UIViewController {

    @IBOutlet weak var chatBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpSWRevealViewController()
    }
    
    func setUpSWRevealViewController() {
        chatBtn.addTarget(self.revealViewController(), action: #selector(SWRevealViewController.revealToggle(_:)), for: .touchUpInside)
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        self.view.addGestureRecognizer(self.revealViewController().tapGestureRecognizer())
    }
}
