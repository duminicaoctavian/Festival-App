//
//  EditProfileViewController.swift
//  Festival-App
//
//  Created by Duminica Octavian on 15/04/2018.
//  Copyright © 2018 Duminica Octavian. All rights reserved.
//

import UIKit

class EditProfileViewController: UIViewController {
    
    lazy var presenter: EditProfilePresenter = {
        return EditProfilePresenter(view: self)
    }()
    
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var confirmPasswordTextField: UITextField!
    @IBOutlet weak var profileImageView: CircleImage!
    @IBOutlet weak var changeProfileButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        addGestures()
        presenter.viewDidLoad()
    }
    
    @IBAction func onSavePressed(_ sender: Any) {
        presenter.usernameChanged(usernameTextField.text)
        presenter.passwordChanged(passwordTextField.text)
        presenter.confirmPassword(confirmPasswordTextField.text)
        
        guard let image = profileImageView.image else { return }
        guard let imageData = UIImageJPEGRepresentation(image, 0) else { return }
        
        presenter.saveData(withImageData: imageData)
    }

    @IBAction func onCloseTapped(_ sender: Any) {
        navigateToProfileScreen()
    }
    
    @IBAction func onChangeImageTapped(_ sender: Any) {
        displayImagePicker()
    }
    
    private func addGestures() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        let pictureTap = UITapGestureRecognizer(target: self, action: #selector(handlePictureTap))
        
        profileImageView.isUserInteractionEnabled = true
        profileImageView.addGestureRecognizer(pictureTap)
        view.addGestureRecognizer(tap)
        
    }
    
    private func handleImageSelected(fromInfo info: [String: Any]) {
        var selectedImageFromPicker: UIImage?
        
        if let editedImage = info[UIImagePickerControllerEditedImage] as? UIImage {
            selectedImageFromPicker = editedImage
        } else if let originalImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            selectedImageFromPicker = originalImage
        }
        
        if let selectedImage = selectedImageFromPicker {
            profileImageView.image = selectedImage
        }
    }
    
    @objc func handleTap() {
        view.endEditing(true)
    }
    
    @objc func handlePictureTap() {
        displayImagePicker()
    }
}

extension EditProfileViewController : UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        handleImageSelected(fromInfo: info)
        dismiss(animated:true, completion: nil)
    }
}

extension EditProfileViewController: EditProfileView {
    
    func displayProfileImage(_ URLString: String) {
        profileImageView.loadImageUsingCache(withURLString: URLString)
    }
    
    func displayImagePicker() {
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.allowsEditing = true
            imagePicker.sourceType = .photoLibrary;
            present(imagePicker, animated: true, completion: nil)
        }
    }
    
    func displayUsername(_ username: String) {
        usernameTextField.text = username
    }
    
    func navigateToProfileScreen() {
        dismiss(animated: true, completion: nil)
    }
}
