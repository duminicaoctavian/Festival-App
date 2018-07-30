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
        
        print(AuthService.instance.isLoggedIn)
        print(AuthService.instance.userEmail)
        print(AuthService.instance.authToken)
        print(AuthService.instance.imageUrl)
        print(AuthService.instance.userName)
        print(AuthService.instance.id)
        
        if let _ = UserDefaults.standard.object(forKey: USER_PROFILE_IMG) as? NSData {
            print("Image is persistent")
        } else {
            if AuthService.instance.imageUrl != "" {
                
                let imageUrl = URL(string: AuthService.instance.imageUrl)!
                
                // Start background thread so that image loading does not make app unresponsive
                DispatchQueue.global(qos: .userInitiated).async {
                    
                    let imageData = NSData(contentsOf: imageUrl)!
                    
                    // When from background thread, UI needs to be updated on main_queue
                    DispatchQueue.main.async {
                        
                        UserDefaults.standard.set(imageData, forKey: USER_PROFILE_IMG)
                    }
                }
            }
        }
    }
    
    func setUpSWRevealViewController() {
        menuBtn.addTarget(self.revealViewController(), action: #selector(SWRevealViewController.revealToggle(_:)), for: .touchUpInside)
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        self.view.addGestureRecognizer(self.revealViewController().tapGestureRecognizer())
    }
    
    @IBAction func onChatPressed(_ sender: Any) {
        performSegue(withIdentifier: TO_CHAT, sender: self)
    }
    
    @IBAction func unwindToHome(segue:UIStoryboardSegue) { }
}
