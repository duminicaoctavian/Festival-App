//
//  CMainPresenter.swift
//  Festival-App
//
//  Created by Octavian Duminica on 15/01/2019.
//  Copyright © 2019 Duminica Octavian. All rights reserved.
//

import Foundation

class CMainPresenter {
    
    private var offers = [Offer]()
    private var users = [User]()
    
    weak var view: CMainView?
    
    var numbersOfPendingOffers: Int {
        return ApplicationService.shared.applications.count
    }
    
    init(view: CMainView) {
        self.view = view
    }
    
    func loadOffers() {
        view?.startActivityIndicator()
        // load applications
        ApplicationService.shared.getAllApplications(forCompany: AuthService.shared.user.id) { [weak self] (success) in
            self?.view?.stopActivityIndicator()
            if success {
                self?.view?.reloadData()
            } else {
                self?.view?.displayAlert(title: "Info", message: "Failure to get applications.")
            }
        }
    }
    
    func removeOffers() {
        ApplicationService.shared.clearApplications()
    }
    
    func configure(_ itemView: CPendingOfferItemView, at index: Int) {
        let application = ApplicationService.shared.applications[index]
        
        itemView.displayOfferTitle(application.offerTitle)
        itemView.displayApplicantImage(application.userImageURL)
    }
}
