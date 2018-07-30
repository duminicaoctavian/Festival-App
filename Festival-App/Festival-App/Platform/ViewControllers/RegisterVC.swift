//
//  RegisterVC.swift
//  Festival-App
//
//  Created by Duminica Octavian on 03/03/2018.
//  Copyright © 2018 Duminica Octavian. All rights reserved.
//

import UIKit

class RegisterVC: UIViewController {
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var usernameTextField: UITextField!
    
    lazy var visualEffectView: UIVisualEffectView = {
        let blurEffect = UIBlurEffect(style: .dark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = self.view.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        return blurEffectView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(RegisterVC.handleTap))
        
        view.addGestureRecognizer(tap)
    }
    
    @objc func handleTap() {
        view.endEditing(true)
    }
    
    @IBAction func onBackPressed(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func onSignUpPressed(_ sender: Any) {
        let emailInput = emailTextField.text!
        let passwordInput = passwordTextField.text!
        let usernameInput = usernameTextField.text!
            
        startActivityIndicator()
        
        AuthService.instance.registerUser(username: usernameInput, email: emailInput, password: passwordInput, completion: { (success) in
            if (success) {
                self.stopActivityIndicator()
                self.performSegue(withIdentifier: TO_HOME_FROM_REGISTER, sender: self)
            } else {
                self.passwordTextField.text = ""
                self.emailTextField.text = ""
                self.usernameTextField.text = ""
                
                self.stopActivityIndicator()
                
                let alertController = UIAlertController(title: "Registration Failed", message: "Invalid input data.", preferredStyle: .alert)
                //We add buttons to the alert controller by creating UIAlertActions:
                let actionOk = UIAlertAction(title: "OK", style: .default, handler: { (_) in
                    self.visualEffectView.removeFromSuperview()
                })
                alertController.addAction(actionOk)
                self.present(alertController, animated: true, completion: nil)
            }
        })
    }
    
    
    func startActivityIndicator() {
        view.addSubview(visualEffectView)
        LoadingView.startLoading()
    }
    
    func stopActivityIndicator() {
        LoadingView.stopLoading()
    }
}
