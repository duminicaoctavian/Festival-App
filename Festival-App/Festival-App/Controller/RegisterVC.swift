//
//  RegisterVC.swift
//  Festival-App
//
//  Created by Duminica Octavian on 03/03/2018.
//  Copyright © 2018 Duminica Octavian. All rights reserved.
//

import UIKit

class RegisterVC: UIViewController {

    @IBOutlet weak var spinner: UIActivityIndicatorView!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var usernameTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        spinner.isHidden = true
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(RegisterVC.handleTap))
        
        view.addGestureRecognizer(tap)
    }
    
    @objc func handleTap() {
        view.endEditing(true)
    }
    
    @IBAction func onBackPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func onSignUpPressed(_ sender: Any) {
        let emailInput = emailTextField.text!
        let passwordInput = passwordTextField.text!
        let usernameInput = usernameTextField.text!
            
        spinner.isHidden = false
        spinner.startAnimating()
        
        AuthService.instance.registerUser(username: usernameInput, email: emailInput, password: passwordInput, completion: { (success) in
            if (success) {
                self.performSegue(withIdentifier: TO_HOME_FROM_REGISTER, sender: self)
            } else {
                self.passwordTextField.text = ""
                self.emailTextField.text = ""
                self.usernameTextField.text = ""
                
                self.spinner.isHidden = true
                self.spinner.stopAnimating()
                
                let alertController = UIAlertController(title: "Registration Failed", message: "Invalid input data.", preferredStyle: .alert)
                //We add buttons to the alert controller by creating UIAlertActions:
                let actionOk = UIAlertAction(title: "OK",
                                             style: .default,
                                             handler: nil) //You can use a block here to handle a press on this button
                
                alertController.addAction(actionOk)
                self.present(alertController, animated: true, completion: nil)
            }
        })
    }
        
}
