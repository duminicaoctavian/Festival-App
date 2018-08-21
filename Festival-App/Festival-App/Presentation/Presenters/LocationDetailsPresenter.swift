//
//  LocationDetailsPresenter.swift
//  Festival-App
//
//  Created by Octavian Duminica on 21/08/2018.
//  Copyright © 2018 Duminica Octavian. All rights reserved.
//

import Foundation

class LocationDetailsPresenter {
    weak var view: LocationDetailsView?
    
    var location: Location?
    
    var numberOfImages: Int {
        guard let count = location?.images.count else { return 0 }
        return count
    }
    
    init(view: LocationDetailsView) {
        self.view = view
    }
    
    func viewDidLoad() {
        guard let location = location else { return }
        getOffererByID(location.userID)
        
        
        view?.displayTitle(location.title)
        view?.displayAddress(location.address)
        view?.displayPrice(String(location.price))
        view?.displayDescription(location.description)
        for index in 0..<location.images.count {
            view?.displayImage(location.images[index], at: index)
        }
    }
    
    func callNumber() {
        // TODO
        if let URL = URL(string: "tel://0745047302") {
            UIApplication.shared.open(URL, options: [:], completionHandler: nil)
        }
    }
    
    func locationChanged(_ newValue: Location?) {
        location = newValue
    }
    
    private func getOffererByID(_ id: String) {
        AuthService.shared.findUserByID(id: id) { [weak self] (user) in
            guard let weakSelf = self else { return }
            if let user = user {
                weakSelf.view?.displayOffererName(user.username)
                weakSelf.view?.displayOferrerProfilePicture(user.imageURL)
            }
        }
    }
}
