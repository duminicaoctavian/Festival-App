//
//  ViewControllerExtensions.swift
//  Festival-App
//
//  Created by Octavian Duminica on 31/07/2018.
//  Copyright © 2018 Duminica Octavian. All rights reserved.
//

import UIKit

extension UIViewController {
    
    @objc func dismissKeyboard() {
        self.view.endEditing(true)
    }
    
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tap.cancelsTouchesInView = false
        self.view.addGestureRecognizer(tap)
    }
}


