//
//  EditProfileVC.swift
//  Festival-App
//
//  Created by Duminica Octavian on 15/04/2018.
//  Copyright © 2018 Duminica Octavian. All rights reserved.
//

import UIKit
import AWSS3
import AWSCognito

class EditProfileVC: UIViewController {
    @IBOutlet weak var usernameTxtField: UITextField!
    @IBOutlet weak var passwordTxtField: UITextField!
    @IBOutlet weak var confirmPasswordTxtField: UITextField!
    @IBOutlet weak var profileImgView: CircleImage!
    @IBOutlet weak var chageProfileBtn: UIButton!
    
    let bucketName = "octaviansuniversalbucket"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        chageProfileBtn.setTitle("Change Image", for: .normal)
        chageProfileBtn.sizeToFit()
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(LoginVC.handleTap))
        
        view.addGestureRecognizer(tap)
        
        // Initialize the Amazon Cognito credentials provider
        
        let credentialsProvider = AWSCognitoCredentialsProvider(regionType:.EUCentral1,
                                                                identityPoolId:"eu-central-1:63c762b5-ff45-4253-937b-dd9f1a822a3b")
        
        let configuration = AWSServiceConfiguration(region:.EUCentral1, credentialsProvider:credentialsProvider)
        
        AWSServiceManager.default().defaultServiceConfiguration = configuration
    }
    
    @objc func handleTap() {
        view.endEditing(true)
    }
    
    @IBAction func onSavePressed(_ sender: Any) {
        let usernameInput = usernameTxtField.text!
        let passwordInput = passwordTxtField.text!
        UserDataService.instance.editUser(username: usernameInput, password: passwordInput) { (success) in
            if success {
                //self.uploadFile(with: "camera", type: "png")
                self.dismiss(animated: true, completion: nil)
            }
        }
    }
    
    func uploadFile(with resource: String, type: String) {
        let key = "\(resource).\(type)"
        let localImagePath = Bundle.main.path(forResource: resource, ofType: type)!
        let localImageUrl = URL(fileURLWithPath: localImagePath)
        
        let request = AWSS3TransferManagerUploadRequest()!
        request.bucket = bucketName
        request.key = key
        request.body = localImageUrl
        request.acl = .publicReadWrite
        
        let transferManager = AWSS3TransferManager.default()
        transferManager.upload(request).continueWith(executor: AWSExecutor.mainThread()) { (task) -> Any? in
            if let error = task.error {
                print(error)
            }
            if task.result != nil {
                print("Uploaded \(key)")
            }
            
            return nil
        }
    }
    
    
    
    @IBAction func onClosePressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func onChangeImgPressed(_ sender: Any) {
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = .photoLibrary;
            imagePicker.allowsEditing = true
            self.present(imagePicker, animated: true, completion: nil)
        }
    }
}

extension EditProfileVC : UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let image = info[UIImagePickerControllerOriginalImage] as! UIImage
        profileImgView.image = image
        dismiss(animated:true, completion: nil)
    }
}
