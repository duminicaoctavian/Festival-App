//
//  MyOffersPresenter.swift
//  Festival-App
//
//  Created by Octavian Duminica on 05/09/2018.
//  Copyright © 2018 Duminica Octavian. All rights reserved.
//

import Foundation

class MyOfferPresenter {
    weak var view: MyOfferView?
    
    var locationsCount: Int {
        return LocationService.shared.locations.count
    }
    
    init(view: MyOfferView) {
        self.view = view
    }
    
    func viewDidLoad() {
        LocationService.shared.clearLocations()
        let currentUserID = AuthService.shared.user.id
        
        view?.startActivityIndicator()
        LocationService.shared.getLocationsForUser(withID: currentUserID) { [weak self] (success) in
            guard let weakSelf = self else { return }
            weakSelf.view?.stopActivityIndicator()
            
            if success {
                DispatchQueue.main.async { [weak self] in
                    guard let weakSelf = self else { return }
                    weakSelf.view?.reloadData()
                }
            } else {
                // TODO
            }
        }
    }
    
    func getLocationAtIndex(_ index: Int) -> Location {
        return LocationService.shared.locations[index]
    }
    
    func configure(_ itemView: OfferItemView, at index: Int) {
        let location = LocationService.shared.locations[index]
        
        itemView.displayTitle(location.title)
        itemView.displayDescription(location.description)
        itemView.displayPrice(String(location.price))
    }
}
