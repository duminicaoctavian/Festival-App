//
//  IRegisterViewController.swift
//  Festival-App
//
//  Created by Octavian Duminica on 15/01/2019.
//  Copyright © 2019 Duminica Octavian. All rights reserved.
//

import UIKit

private struct Constants {
    static let alertTitle = "Registration Failed!"
    static let alertMessage = "Invalid data!"
    static let okActionTitle = "OK"
}

class IRegisterViewController: UIViewController {
    
    lazy var presenter: IRegisterPresenter = {
        return IRegisterPresenter(view: self)
    }()
    
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var roleSegmentedControl: UISegmentedControl!
    @IBOutlet weak var confirmPasswordTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    lazy var visualEffectView: UIVisualEffectView = {
        let blurEffect = UIBlurEffect(style: .light)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = self.view.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        return blurEffectView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hideKeyboardWhenTappedAround()
    }
    
    @IBAction func onSignUpTapped(_ sender: Any) {
        startActivityIndicator()
        presenter.usernameChanged(usernameTextField.text)
        presenter.emailChanged(emailTextField.text)
        presenter.passwordChanged(passwordTextField.text)
        presenter.confirmPasswordChanged(confirmPasswordTextField.text)
        presenter.register()
    }
    
    @IBAction func segmentedControlValueChanged(_ sender: UISegmentedControl) {
        presenter.segmentedControlValueChanged(index: sender.selectedSegmentIndex)
    }
    
    private func displayRegisterFailedAlert(forError error: Error?) {
        let message = error != nil ? error?.localizedDescription : Constants.alertMessage
        let alert = UIAlertController(title: Constants.alertTitle, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: Constants.okActionTitle, style: .default, handler: { [weak self] (action) in
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

extension IRegisterViewController: IRegisterView {
    func navigateToApplicantScreen() {
        guard let applicantViewController = storyboard?.instantiateViewController(withIdentifier: Storyboard.AMainViewController) as? AMainViewController else { return }
        navigationController?.pushViewController(applicantViewController, animated: true)
    }
    
    func navigateToUniversityScreen() {
        guard let uViewController = storyboard?.instantiateViewController(withIdentifier: Storyboard.UMainViewController) as? UMainViewController else { return }
        navigationController?.pushViewController(uViewController, animated: true)
    }
    
    func navigateToCompanyScreen() {
        guard let cViewController = storyboard?.instantiateViewController(withIdentifier: Storyboard.CMainViewController) as? CMainViewController else { return }
        navigationController?.pushViewController(cViewController, animated: true)
    }
    
    func startActivityIndicator() {
        view.addSubview(visualEffectView)
        LoadingView.startLoading()
    }
    
    func stopActivityIndicator() {
        visualEffectView.removeFromSuperview()
        LoadingView.stopLoading()
    }
    
    func presentRegisterFailedFeedback(forError error: Error?) {
        stopActivityIndicator()
        resetTextFields()
        displayRegisterFailedAlert(forError: error)
    }
}
