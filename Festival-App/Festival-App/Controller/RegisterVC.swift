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
    @IBOutlet weak var confirmPasswordTextField: UITextField!
    
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
        let confirmPasswordInput = confirmPasswordTextField.text!
        
        if passwordInput != confirmPasswordInput {
            print("PASSWORDS DO NOT MATCH!")
        } else {
            spinner.isHidden = false
            spinner.startAnimating()
            
            AuthService.instance.registerUser(email: emailInput, password: passwordInput, completion: { (success) in
                if success {
                    self.performSegue(withIdentifier: TO_HOME_FROM_REGISTER, sender: self)
                }
            })
        }
        
    }
}
