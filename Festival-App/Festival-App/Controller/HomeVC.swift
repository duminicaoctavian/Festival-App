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
        
        if AuthService.instance.imageUrl != "" {

            let imageUrl = URL(string: AuthService.instance.imageUrl)!


            if let imageFromCache = globalCache.object(forKey: AuthService.instance.imageUrl as AnyObject) as? UIImage {
                //self.artistImageView.image = imageFromCache
                print("Already in Cache")
                return
            }

            // Start background thread so that image loading does not make app unresponsive
            DispatchQueue.global(qos: .userInitiated).async {

                let imageData = NSData(contentsOf: imageUrl)!

                // When from background thread, UI needs to be updated on main_queue
                DispatchQueue.main.async {
                    let imageToCache = UIImage(data: imageData as Data)

                    globalCache.setObject(imageToCache!, forKey: AuthService.instance.imageUrl as AnyObject)
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
