//
//  LoginViewController.swift
//  Festival-App
//
//  Created by Duminica Octavian on 26/02/2018.
//  Copyright © 2018 Duminica Octavian. All rights reserved.
//

import UIKit

private struct Constants {
    static let alertTitle = "Login Failed"
    static let alertMessage = "Invalid data!"
    static let okActionTitle = "OK"
    static let longPressDuration = 0.5
    static let cornerRadius: CGFloat = 5.0
}

class LoginViewController: UIViewController {
    
    lazy var presenter: LoginPresenter = {
        return LoginPresenter(view: self)
    }()
    
    lazy var longPress: UILongPressGestureRecognizer = {
        let longPress = UILongPressGestureRecognizer(target: self, action: #selector(showBackendView))
        longPress.minimumPressDuration = Constants.longPressDuration
        return longPress
    }()
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var backendView: UIView!
    @IBOutlet weak var backendLabel: UILabel!
    @IBOutlet weak var backendSwitch: UISwitch!
    
    lazy var visualEffectView: UIVisualEffectView = {
        let blurEffect = UIBlurEffect(style: .dark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = self.view.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        return blurEffectView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        roundBackendView()
        hideNavigationBar()
        hideKeyboardWhenTappedAround()
        addGestures()
    }
    
    private func addGestures() {
        view.addGestureRecognizer(longPress)
    }
    
    @IBAction func onLoginTapped(_ sender: Any) {
        startActivityIndicator()
        presenter.emailChanged(emailTextField.text)
        presenter.passwordChanged(passwordTextField.text)
        presenter.login()
    }
    
    @IBAction func onRegisterTapped(_ sender: Any) {
        navigateToRegisterScreen()
    }
    
    @IBAction func onCloseTapped(_ sender: Any) {
        hideBackendView()
    }
    
    @IBAction func backendSwitchChanged(_ sender: UISwitch) {
        presenter.handleSwitch(forValue: sender.isOn)
    }
    
    private func displayLoginFailedAlert(forError error: Error?) {
        let message = error != nil ? error?.localizedDescription : Constants.alertMessage
        let alert = UIAlertController(title: Constants.alertTitle, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: Constants.okActionTitle, style: .default, handler: { [weak self] (_) in
            guard let weakSelf = self else { return }
            weakSelf.visualEffectView.removeFromSuperview()
        })
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
    }
    
    private func resetPasswordTextField() {
        passwordTextField.text = ""
    }
}

extension LoginViewController: LoginView {
    func presentLoginFailedFeedback(forError error: Error?) {
        stopActivityIndicator()
        resetPasswordTextField()
        displayLoginFailedAlert(forError: error)
    }
    
    @objc func showBackendView() {
        backendView.isHidden = false
        presenter.handleLabelTitle()
        presenter.showSwitch()
    }
    
    func hideBackendView() {
        backendView.isHidden = true
    }
    
    func displaySwitch(value: Bool) {
        backendSwitch.isOn = value
    }
    
    func displayBackendLabel(_ title: String) {
        backendLabel.text = title
    }
    
    func hideNavigationBar() {
        navigationController?.navigationBar.isHidden = true
    }
    
    func navigateToHomeScreen() {
        performSegue(withIdentifier: Segue.toHomeFromLogin, sender: self)
    }
    
    func navigateToRegisterScreen() {
        performSegue(withIdentifier: Segue.toRegister, sender: self)
    }
    
    func startActivityIndicator() {
        view.addSubview(visualEffectView)
        LoadingView.startLoading()
    }
    
    func stopActivityIndicator() {
        LoadingView.stopLoading()
    }
    
    func roundBackendView() {
        backendView.clipsToBounds = true
        backendView.layer.cornerRadius = Constants.cornerRadius
    }
}
