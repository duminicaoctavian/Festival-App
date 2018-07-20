//
//  LoginViewController.swift
//  Festival-App
//
//  Created by Duminica Octavian on 26/02/2018.
//  Copyright © 2018 Duminica Octavian. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    lazy var presenter: LoginPresenter = {
        return LoginPresenter(view: self)
    }()

    @IBOutlet weak var spinner: UIActivityIndicatorView!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        spinner.isHidden = true
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(LoginViewController.handleTap))
        
        view.addGestureRecognizer(tap)
    }
    
    @objc func handleTap() {
        view.endEditing(true)
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
                self.performSegue(withIdentifier: TO_HOME_FROM_LOGIN, sender: self)
            } else {
                self.spinner.isHidden = true
                self.spinner.stopAnimating()
                self.emailTextField.text = ""
                self.passwordTextField.text = ""
                
                let alertController = UIAlertController(title: "Login Failed", message: "Please try again.", preferredStyle: .alert)
                //We add buttons to the alert controller by creating UIAlertActions:
                let actionOk = UIAlertAction(title: "OK",
                                             style: .default,
                                             handler: nil) //You can use a block here to handle a press on this button
                
                alertController.addAction(actionOk)
                self.present(alertController, animated: true, completion: nil)
            }
        }
    }
    @IBAction func onRegisterPressed(_ sender: Any) {
        performSegue(withIdentifier: TO_REGISTER, sender: self)
    }
}

extension LoginViewController: LoginView {
    func displayLoginFailedAlert() {
        
    }
    
    func navigateToHomeScreen() {
    
    }
    
    func navigateToCreateAccountScreen() {
        
    }
    
    func roundLoginButton() {
        
    }
    
    func startActivityIndicator() {
        
    }
    
    func stopActivityIndicator() {
        
    }
}