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
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    lazy var visualEffectView: UIVisualEffectView = {
        let blurEffect = UIBlurEffect(style: .dark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = self.view.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        return blurEffectView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.isHidden = true
        
        addGestures()
    }
    
    private func addGestures() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        view.addGestureRecognizer(tap)
    }
    
    @objc func handleTap() {
        view.endEditing(true)
    }
    
    @IBAction func onLoginPressed(_ sender: Any) {
        startActivityIndicator()
        let emailInput = emailTextField.text!
        let passwordInput = passwordTextField.text!
        AuthService.instance.loginUser(email: emailInput, password: passwordInput) { (success) in
            if (success) {
                self.stopActivityIndicator()
                self.performSegue(withIdentifier: TO_HOME_FROM_LOGIN, sender: self)
            } else {
                self.stopActivityIndicator()
                self.emailTextField.text = ""
                self.passwordTextField.text = ""
                
                let alertController = UIAlertController(title: "Login Failed", message: "Please try again.", preferredStyle: .alert)
                //We add buttons to the alert controller by creating UIAlertActions:
                let actionOk = UIAlertAction(title: "OK", style: .default, handler: { (_) in
                    self.visualEffectView.removeFromSuperview()
                })
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
        view.addSubview(visualEffectView)
        LoadingView.startLoading()
    }
    
    func stopActivityIndicator() {
        LoadingView.stopLoading()
    }
}
