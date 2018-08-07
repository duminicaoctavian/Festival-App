//
//  EditProfilePresenter.swift
//  Festival-App
//
//  Created by Octavian Duminica on 07/08/2018.
//  Copyright © 2018 Duminica Octavian. All rights reserved.
//

import Foundation

class EditProfilePresenter {
    weak var view: EditProfileView?
    
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
        StorageService.instance.setupProvider()
        view?.displayUsername(AuthService.instance.user.username)
        view?.displayProfileImage(AuthService.instance.user.imageURL)
    }
    
    func saveData(withImageData imageData: Data) {
        guard let username = username, let password = password, let _ = confirmPassword else { return }
        let imageName = NSUUID().uuidString + ".jpg"
        let imageURL = "\(Route.baseAWS)/\(imageName)"
        
        AuthService.instance.editUser(username: username, password: password, imageURL: imageURL) { [weak self] (success) in
            guard let weakSelf = self else { return }
            
            if success {
                StorageService.instance.uploadFile(imageName: imageName, withData: imageData, completion: { (success) in
                    if success {
                        NotificationCenter.default.post(name: NotificationName.userEdited, object: nil)
                        weakSelf.view?.navigateToProfileScreen()
                    } else {
                        // TODO
                    }
                })
            }
        }
    }
}
