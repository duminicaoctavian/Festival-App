//
//  ADetailsPresenter.swift
//  Festival-App
//
//  Created by Octavian Duminica on 16/01/2019.
//  Copyright © 2019 Duminica Octavian. All rights reserved.
//

import Foundation

class ADetailsPresenter {
    
    private var offer: Offer!
    var application = Application()
    var resumeData: Data?
    
    weak var view: ADetailsView?
    
    init(view: ADetailsView) {
        self.view = view
    }
    
    func setOffer(_ newValue: Offer) {
        offer = newValue
    }
    
    func loadOffer() {
        view?.displayCompanyImage(offer.companyImageURL)
        view?.displayOfferTitle(offer.title)
        view?.displayOfferDescription(offer.description)
    }
    
    func call() {
        view?.callNumber(offer.phone)
    }
    
    func uploadResume() {
        view?.openFilePicker()
    }
    
    func apply() {
        guard let resumeData = resumeData else {
            view?.displayAlert(title: "Info", message: "No resume was selected")
            return
        }
        
        let fileName = NSUUID().uuidString + ".pdf"
        let fileURL = "\(Route.baseAWS)/\(fileName)"
        
        StorageService.shared.setupProvider()
        
        view?.startActivityIndicator()
        StorageService.shared.uploadFile(imageName: fileName, withData: resumeData) { [weak self] (success) in
            if success {
                
                self?.handleUpload(fileURL)
            } else {
                self?.view?.stopActivityIndicator()
                self?.view?.displayAlert(title: "Info", message: "Failure to upload resume.")
            }
        }
    }
    
    private func handleUpload(_ resumeURL: String) {
        
        ApplicationService.shared.apply(userID: AuthService.shared.user.id, offerID: offer.id, projects: application.projects, resumeURL: resumeURL, phone: application.phone, companyID: offer.userID, offerTitle: offer.title) { [weak self] (success) in
            self?.view?.stopActivityIndicator()
            if success {
                self?.view?.displayAlert(title: "Info", message: "Application has been sent.")
            } else {
                self?.view?.displayAlert(title: "Info", message: "Failure to send application")
            }
        }
    }
    
    func setResumeData(_ newValue: Data) {
        resumeData = newValue
    }
    
    func setApplication(projects: String, phone: String) {
        application.projects = projects
        application.phone = "0745047302"
    }
}

