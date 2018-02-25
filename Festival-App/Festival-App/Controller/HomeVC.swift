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
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    @IBOutlet weak var menuBtn: UIButton!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var ultraLogoImageView: UIImageView!
    @IBOutlet weak var ultraTextImageView: UIImageView!
    @IBOutlet weak var buyTicketsButton: RoundedButton!
    @IBOutlet weak var loginStackView: UIStackView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpSWRevealViewController()
        spinner.isHidden = true
        
        if AuthService.instance.isLoggedIn {
            self.loginStackView.isHidden = true
            // reveal the others
            self.menuBtn.isEnabled = true
            self.menuBtn.isHidden = false
            self.ultraLogoImageView.isHidden = false
            self.ultraTextImageView.alpha = 1
            self.ultraTextImageView.isHidden = false
            self.ultraLogoImageView.alpha = 1
            self.buyTicketsButton.isHidden = false
            self.buyTicketsButton.isEnabled = true
            self.buyTicketsButton.alpha = 1
        }
    }
    
    func setUpSWRevealViewController() {
        menuBtn.addTarget(self.revealViewController(), action: #selector(SWRevealViewController.revealToggle(_:)), for: .touchUpInside)
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        self.view.addGestureRecognizer(self.revealViewController().tapGestureRecognizer())
    }
    
    @IBAction func onLoginPressed(_ sender: Any) {
        spinner.isHidden = false
        spinner.startAnimating()
        let emailInput = emailTextField.text!
        let passwordInput = passwordTextField.text!
        AuthService.instance.loginUser(email: emailInput, password: passwordInput) { (success) in
            self.loginStackView.dim()
            //self.loginStackView.isHidden = true
            self.spinner.isHidden = true
            self.spinner.stopAnimating()
            // reveal the others
            self.menuBtn.isEnabled = true
            self.menuBtn.isHidden = false
            self.ultraLogoImageView.isHidden = false
            self.ultraLogoImageView.unDim()
            self.ultraTextImageView.isHidden = false
            self.ultraTextImageView.unDim()
            self.buyTicketsButton.isHidden = false
            self.buyTicketsButton.unDim()
            self.buyTicketsButton.isEnabled = true
        }
    }
}

extension UIView {
    func dim() {
        UIView.animate(withDuration: 0.3, animations: {
            self.alpha = 0
        })
    }
    
    func unDim() {
        UIView.animate(withDuration: 0.7, animations: {
            self.alpha = 1.0
        })
    }
}
