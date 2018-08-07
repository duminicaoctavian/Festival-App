//
//  ProfilePresenter.swift
//  Festival-App
//
//  Created by Octavian Duminica on 07/08/2018.
//  Copyright © 2018 Duminica Octavian. All rights reserved.
//

import Foundation

class ProfilePresenter {
    weak var view: ProfileView?
    
    init(view: ProfileView) {
        self.view = view
    }
    
    func viewDidLoad() {
        NotificationCenter.default.addObserver(self, selector: #selector(userEdited(_:)), name: NotificationName.userEdited, object: nil)
    }
    
    func viewWillAppear() {
        view?.displayUsername(AuthService.instance.user.username)
        view?.displayProfileImage(AuthService.instance.user.imageURL)
    }
    
    @objc func userEdited(_ notification: Notification) {
        view?.displayUsername(AuthService.instance.user.username)
        view?.displayProfileImage(AuthService.instance.user.imageURL)
    }
}
