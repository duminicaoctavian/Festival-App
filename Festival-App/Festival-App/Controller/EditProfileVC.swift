//
//  EditProfileVC.swift
//  Festival-App
//
//  Created by Duminica Octavian on 15/04/2018.
//  Copyright © 2018 Duminica Octavian. All rights reserved.
//

import UIKit

class EditProfileVC: UIViewController {
    @IBOutlet weak var usernameTxtField: UITextField!
    @IBOutlet weak var passwordTxtField: UITextField!
    @IBOutlet weak var confirmPasswordTxtField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
    }
    @IBAction func onSavePressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    @IBAction func onChangePasswordPressed(_ sender: Any) {
        passwordTxtField.isHidden = false
        confirmPasswordTxtField.isHidden = false
    }
}
