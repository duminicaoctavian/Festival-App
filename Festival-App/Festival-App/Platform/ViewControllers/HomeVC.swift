//
//  HomeVC.swift
//  Festival-App
//
//  Created by Duminica Octavian on 21/02/2018.
//  Copyright © 2018 Duminica Octavian. All rights reserved.
//

import UIKit

let globalCache = NSCache<AnyObject, AnyObject>()

class HomeVC: UIViewController {
    
    // Outlets
    @IBOutlet weak var menuBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpSWRevealViewController()
        
        navigationController?.navigationBar.isHidden = true
        
        print(AuthService.instance.user)
    }
    
    func setUpSWRevealViewController() {
        menuBtn.addTarget(self.revealViewController(), action: #selector(SWRevealViewController.revealToggle(_:)), for: .touchUpInside)
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        self.view.addGestureRecognizer(self.revealViewController().tapGestureRecognizer())
    }
    
    @IBAction func onChatPressed(_ sender: Any) {
        performSegue(withIdentifier: Segue.toChat, sender: self)
    }
    
    @IBAction func unwindToHome(segue:UIStoryboardSegue) { }
}
