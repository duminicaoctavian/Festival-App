//
//  LoginVC.swift
//  Festival-App
//
//  Created by Duminica Octavian on 26/02/2018.
//  Copyright © 2018 Duminica Octavian. All rights reserved.
//

import UIKit

class LoginVC: UIViewController {

   
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        spinner.isHidden = true
    }
    
    @IBAction func onLoginPressed(_ sender: Any) {
        spinner.isHidden = false
        spinner.startAnimating()
        let emailInput = emailTextField.text!
        let passwordInput = passwordTextField.text!
        AuthService.instance.loginUser(email: emailInput, password: passwordInput) { (success) in
            if (success) {
                self.spinner.isHidden = true
                self.spinner.stopAnimating()
                self.performSegue(withIdentifier: TO_HOME, sender: self)
            }
        }
    }
}
