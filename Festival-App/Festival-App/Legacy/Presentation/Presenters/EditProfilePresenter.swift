//
//  EditProfilePresenter.swift
//  Festival-App
//
//  Created by Octavian Duminica on 07/08/2018.
//  Copyright © 2018 Duminica Octavian. All rights reserved.
//

import Foundation

protocol EditProfilePresenterDelegate: class {
    func userDataDidChange()
}

class EditProfilePresenter {
    weak var view: EditProfileView?
    var delegate: EditProfilePresenterDelegate?
    
    init(view: EditProfileView) {
        self.view = view
    }
    
    private var username: String?
    private var password: String?
    private var confirmPassword: String?
    
    func usernameChanged(_ newValue: String?) {
        username = newValue
    }
    
    func passwordChanged(_ newValue: String?) {
        password = newValue
    }
    
    func confirmPassword(_ newValue: String?) {
        confirmPassword = newValue
    }
    
    func viewDidLoad() {
        StorageService.shared.setupProvider()
        view?.displayUsername(AuthService.shared.user.username)
        view?.displayProfileImage(AuthService.shared.user.imageURL)
    }
    
    func saveData(withImageData imageData: Data) {
        guard let username = username, let password = password, let _ = confirmPassword else { return }
        let imageName = NSUUID().uuidString + ".jpg"
        let imageURL = "\(Route.baseAWS)/\(imageName)"
        
        view?.startActivityIndicator()
        
        AuthService.shared.editUser(username: username, password: password, imageURL: imageURL) { [weak self] (success) in
            guard let weakSelf = self else { return }
            weakSelf.view?.stopActivityIndicator()
            
            if success {
                StorageService.shared.uploadFile(imageName: imageName, withData: imageData, completion: { (success) in
                    if success {
                        weakSelf.delegate?.userDataDidChange()
                        weakSelf.view?.navigateToProfileScreen()
                    } else {
                        // TODO
                    }
                })
            }
        }
    }
}
