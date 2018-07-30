//
//  ProfileVC.swift
//  Festival-App
//
//  Created by Duminica Octavian on 15/04/2018.
//  Copyright © 2018 Duminica Octavian. All rights reserved.
//

import UIKit

class ProfileVC: UIViewController {

    @IBOutlet weak var menuBtn: UIButton!
    @IBOutlet weak var usernameLbl: UILabel!
    @IBOutlet weak var profileImgView: CircleImage!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.isHidden = true

        setUpSWRevealViewController()
        
        usernameLbl.text = AuthService.instance.userName
        
        NotificationCenter.default.addObserver(self, selector: #selector(ProfileVC.userDataDidChange(_:)), name: NOTIF_USER_EDITED, object: nil)

        if let imageData = UserDefaults.standard.object(forKey: USER_PROFILE_IMG) as? NSData {
            //self.artistImageView.image = imageFromCache
            profileImgView.image = UIImage(data: imageData as Data)
            return
        }
    }
    
    @objc func userDataDidChange(_ notif: Notification) {
        usernameLbl.text = AuthService.instance.userName
        
        if let imageData = UserDefaults.standard.object(forKey: USER_PROFILE_IMG) as? NSData {
            profileImgView.image = UIImage(data: imageData as Data)
            return
        }
    }
    
    
    
    func setUpSWRevealViewController() {
        menuBtn.addTarget(self.revealViewController(), action: #selector(SWRevealViewController.revealToggle(_:)), for: .touchUpInside)
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        self.view.addGestureRecognizer(self.revealViewController().tapGestureRecognizer())
    }
    @IBAction func onViewOrderPressed(_ sender: Any) {
        
    }
    @IBAction func onEditProfilePressed(_ sender: Any) {
        let editProfileVC = EditProfileVC()
        editProfileVC.modalPresentationStyle = .custom
        self.present(editProfileVC, animated: true, completion: nil)
    }
    @IBAction func onSavePressed(_ sender: Any) {
        
        let alertController = UIAlertController(title: "Profile Saved!", message: "Your preferences have been saved.", preferredStyle: .alert)
        //We add buttons to the alert controller by creating UIAlertActions:
        let actionOk = UIAlertAction(title: "OK",
                                     style: .default,
                                     handler: nil) //You can use a block here to handle a press on this button
        
        alertController.addAction(actionOk)
        self.present(alertController, animated: true, completion: nil)
    }
}
