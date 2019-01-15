//
//  ILoginViewController.swift
//  Festival-App
//
//  Created by Octavian Duminica on 15/01/2019.
//  Copyright © 2019 Duminica Octavian. All rights reserved.
//

import UIKit

private struct Constants {
    static let alertTitle = "Login Failed"
    static let alertMessage = "Invalid data!"
    static let okActionTitle = "OK"
    static let cornerRadius: CGFloat = 5.0
}

class ILoginViewController: UIViewController {
    
    lazy var presenter: ILoginPresenter = {
        return ILoginPresenter(view: self)
    }()
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    lazy var visualEffectView: UIVisualEffectView = {
        let blurEffect = UIBlurEffect(style: .light)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = view.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        return blurEffectView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hideKeyboardWhenTappedAround()
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
    
    private func displayLoginFailedAlert(forError error: Error?) {
        let message = error != nil ? error?.localizedDescription : Constants.alertMessage
        let alert = UIAlertController(title: Constants.alertTitle, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: Constants.okActionTitle, style: .default, handler: { [weak self] (action) in
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

extension ILoginViewController: ILoginView {
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
    
    func presentLoginFailedFeedback(forError error: Error?) {
        stopActivityIndicator()
        resetPasswordTextField()
        displayLoginFailedAlert(forError: error)
    }
    
    func navigateToRegisterScreen() {
        guard let registerViewController = storyboard?.instantiateViewController(withIdentifier: Storyboard.IRegisterViewController) as? IRegisterViewController else { return }
        navigationController?.pushViewController(registerViewController, animated: true)
    }
    
    func startActivityIndicator() {
        view.addSubview(visualEffectView)
        LoadingView.startLoading()
    }
    
    func stopActivityIndicator() {
        visualEffectView.removeFromSuperview()
        LoadingView.stopLoading()
    }
}
