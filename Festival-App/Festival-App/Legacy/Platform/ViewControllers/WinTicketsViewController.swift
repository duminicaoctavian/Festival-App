//
//  WinTicketsViewController.swift
//  Festival-App
//
//  Created by Octavian Duminica on 09/08/2018.
//  Copyright © 2018 Duminica Octavian. All rights reserved.
//

import Foundation
import Lottie

private struct Constants {
    static let wrongAnswerAlertTitle = "Oops!"
    static let wrongAnswerAlertMessage = "Wrong answer! Please try again"
    static let actionTitle = "OK"
    static let correctAnswerAlertTitle = "Congratulations!"
    static let correctAnswerAlertMessage = "You answered correctly! You now have a chance to win a free ticket!"
    static let cornerRadius: CGFloat = 20.0
    static let animationName = "confetti"
}

class WinTicketsViewController: UIViewController {
    
    lazy var presenter: WinTicketsPresenter = {
        return WinTicketsPresenter(view: self)
    }()
    
    lazy var visualEffectView: UIVisualEffectView = {
        let blurEffect = UIBlurEffect(style: .dark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = self.view.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        return blurEffectView
    }()
    
    lazy var animationView: LOTAnimationView = {
        let animationView = LOTAnimationView(name: Constants.animationName)
        animationView.contentMode = .scaleAspectFit
        animationView.frame = view.bounds
        animationView.loopAnimation = false
        return animationView
    }()
    
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var questionTitleLabel: UILabel!
    @IBOutlet weak var checkButton: RoundedButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        roundImageCorners()
        addGestures()
        presenter.viewDidLoad()
    }
    
    private func addGestures() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(imageTapped))
        photoImageView.isUserInteractionEnabled = true
        photoImageView.addGestureRecognizer(tap)
    }
    
    @objc func imageTapped() {
        presentImagePicker()
    }
    
    @IBAction func onCheckTapped(_ sender: Any) {
        guard let image = photoImageView.image else { return }
        guard let data = UIImagePNGRepresentation(image) else { return }
        
        presenter.beginRecognitionProcess(forData: data)
    }
    
    @IBAction func onBackTapped(_ sender: Any) {
        navigateToHomeScreen()
    }
}

extension WinTicketsViewController: WinTicketsView {
    func hideAllContent() {
        questionTitleLabel.isHidden = true
        questionLabel.isHidden = true
        photoImageView.isHidden = true
        checkButton.isHidden = true
    }
    
    func displayAllContent() {
        questionTitleLabel.isHidden = false
        questionLabel.isHidden = false
        photoImageView.isHidden = false
        checkButton.isHidden = false
    }
    
    func startActivityIndicator() {
        LoadingView.startLoading()
    }
    
    func stopActivityIndicator() {
        LoadingView.stopLoading()
    }
    
    func roundImageCorners() {
        photoImageView.layer.cornerRadius = Constants.cornerRadius
    }
    
    func presentImagePicker() {
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = .photoLibrary
            present(imagePicker, animated: true, completion: nil)
        }
    }
    
    func displayQuestion(_ question: String) {
        questionLabel.text = question
    }
    
    func navigateToHomeScreen() {
        navigationController?.popViewController(animated: true)
    }
    
    func showWrongAnswerAlert() {
        view.addSubview(visualEffectView)
        let alert = UIAlertController(title: Constants.wrongAnswerAlertTitle, message: Constants.wrongAnswerAlertMessage, preferredStyle: .alert)
        let okAction = UIAlertAction(title: Constants.actionTitle, style: .cancel, handler: { [weak self] (action) in
            guard let weakSelf = self else { return }
            weakSelf.visualEffectView.removeFromSuperview()
        })
        alert.view.tintColor = UIColor.buttonColor
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
    }
    
    func showCorrectAnswerAlert() {
        view.addSubview(visualEffectView)
        view.addSubview(animationView)
        animationView.play { [weak self] (finished) in
            guard let weakSelf = self else { return }
            
            let alert = UIAlertController(title: Constants.correctAnswerAlertTitle, message: Constants.correctAnswerAlertMessage, preferredStyle: .alert)
            let okAction = UIAlertAction(title: Constants.actionTitle, style: .cancel, handler: { [weak self] (action) in
                guard let weakSelf = self else { return }
                weakSelf.visualEffectView.removeFromSuperview()
                weakSelf.animationView.removeFromSuperview()
            })
            alert.view.tintColor = UIColor.buttonColor
            alert.addAction(okAction)
            weakSelf.present(alert, animated: true, completion: nil)
        }
    }
}

extension WinTicketsViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            photoImageView.image = pickedImage
        }
        
        picker.dismiss(animated: true, completion: nil)
    }
}