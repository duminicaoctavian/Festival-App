//
//  RegisterViewController.swift
//  Festival-App
//
//  Created by Duminica Octavian on 03/03/2018.
//  Copyright © 2018 Duminica Octavian. All rights reserved.
//

import UIKit
import Lottie

private struct Constants {
    static let alertTitle = "Registration Failed!"
    static let alertMessage = "Invalid data!"
    static let okActionTitle = "OK"
    static let formAnimationName = "form"
    static let animationSpeed: CGFloat = 3.0
    static let animationStart: CGFloat = 0.2
    static let animationEnd: CGFloat = 1.0
}

class RegisterViewController: UIViewController {
    
    lazy var presenter: RegisterPresenter = {
        return RegisterPresenter(view: self)
    }()
    
    @IBOutlet weak var animationView: UIImageView!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var confirmPasswordTextField: UITextField!
    
    lazy var visualEffectView: UIVisualEffectView = {
        let blurEffect = UIBlurEffect(style: .dark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = self.view.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        return blurEffectView
    }()
    
    lazy var formAnimationView: AnimationView = {
        let formAnimationView = AnimationView(name: Constants.formAnimationName)
        formAnimationView.animationSpeed = Constants.animationSpeed
        formAnimationView.contentMode = .scaleAspectFill
        formAnimationView.frame = animationView.bounds
        formAnimationView.loopMode = .playOnce
        return formAnimationView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        playFormAnimation()
        hideKeyboardWhenTappedAround()
    }

    @IBAction func onBackTapped(_ sender: Any) {
        navigateToLoginScreen()
    }
    
    @IBAction func onSignUpTapped(_ sender: Any) {
        startActivityIndicator()
        presenter.usernameChanged(usernameTextField.text)
        presenter.emailChanged(emailTextField.text)
        presenter.passwordChanged(passwordTextField.text)
        presenter.confirmPasswordChanged(confirmPasswordTextField.text)
        presenter.register()
    }
    
    private func displayRegisterFailedAlert(forError error: Error?) {
        let message = error != nil ? error?.localizedDescription : Constants.alertMessage
        let alert = UIAlertController(title: Constants.alertTitle, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: Constants.okActionTitle, style: .default, handler: { [weak self] (_) in
            guard let weakSelf = self else { return }
            weakSelf.visualEffectView.removeFromSuperview()
        })
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
    }
    
    private func resetTextFields() {
        emailTextField.text = ""
        usernameTextField.text = ""
        passwordTextField.text = ""
        confirmPasswordTextField.text = ""
    }
}

extension RegisterViewController: RegisterView {
    func startActivityIndicator() {
        view.addSubview(visualEffectView)
        LoadingView.startLoading()
    }
    
    func stopActivityIndicator() {
        LoadingView.stopLoading()
    }
    
    func navigateToLoginScreen() {
        navigationController?.popViewController(animated: true)
    }
    
    func navigateToHomeScreen() {
        performSegue(withIdentifier: Segue.toHomeFromRegister, sender: self)
    }
    
    func presentRegisterFailedFeedback(forError error: Error?) {
        stopActivityIndicator()
        resetTextFields()
        displayRegisterFailedAlert(forError: error)
    }
    
    func playFormAnimation() {
        animationView.addSubview(formAnimationView)
        formAnimationView.play(fromProgress: Constants.animationStart, toProgress: Constants.animationEnd, loopMode: .playOnce, completion: nil)
    }
}
