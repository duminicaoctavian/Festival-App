//
//  UserMenuPresenter.swift
//  Festival-App
//
//  Created by Octavian Duminica on 05/08/2018.
//  Copyright © 2018 Duminica Octavian. All rights reserved.
//

import Foundation

class UserMenuPresenter {
    weak var view: UserMenuView?
    
    init(view: UserMenuView) {
        self.view = view
    }
    
    func viewWillAppear() {
        view?.displayUserImage(AuthService.instance.user.imageURL)
    }
    
    func logout() {
        AuthService.instance.logoutUser { [weak self] (success) in
            guard let weakSelf = self else { return }
            
            if success {
                weakSelf.view?.navigateToLoginScreen()
            } else {
                // TODO
            }
        }
    }
    
    func configure(_ itemView: UserMenuItemView, at index: Int) {
        let option = UserMenuOption.rawValues[index]
        itemView.displayOptionName(option)
        itemView.displayOptionImage(option)
    }
}
