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
    weak var editProfilePresenter: EditProfilePresenter?
    
    init(view: ProfileView) {
        self.view = view
    }
    
    func viewWillAppear() {
        loadData()
    }
    
    private func loadData() {
        view?.displayUsername(AuthService.shared.user.username)
        view?.displayProfileImage(AuthService.shared.user.imageURL)
    }
}

extension ProfilePresenter: EditProfilePresenterDelegate {
    func userDataDidChange() {
        loadData()
    }
}


