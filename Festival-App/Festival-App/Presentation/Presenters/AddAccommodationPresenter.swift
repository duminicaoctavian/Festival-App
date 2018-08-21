//
//  AddAccommodationPresenter.swift
//  Festival-App
//
//  Created by Octavian Duminica on 10/08/2018.
//  Copyright © 2018 Duminica Octavian. All rights reserved.
//

import Foundation
import CoreLocation

private struct Constants {
    static let delay = 0.6
}

class AddAccommodationPresenter: NSObject {
    weak var view: AddAccommodationView?
    
    var locationManager = CLLocationManager()
    
    var userCoordinates: (latitude: Double, longitude: Double) {
        get {
            guard let coordinate = locationManager.location?.coordinate else { return (0, 0) }
            return (coordinate.latitude, coordinate.longitude)
        }
    }
    
    var location: Location?
    
    let authorizationStatus = CLLocationManager.authorizationStatus()
    
    init(view: AddAccommodationView) {
        self.view = view
    }
    
    func viewDidLoad() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        
        configureLocationServices()
        view?.centerMapOnUserLocation(withLatitude: userCoordinates.latitude, andLongitude: userCoordinates.longitude)
    }
    
    func viewWillAppear() {
        location = Location()
    }
    
    func titleChanged(_ newValue: String?) {
        guard let newValue = newValue else { return }
        location?.title = newValue
    }
    
    func addressChanged(_ newValue: String?) {
        guard let newValue = newValue else { return }
        location?.address = newValue
    }
    
    func descriptionChanged(_ newValue: String?) {
        guard let newValue = newValue else { return }
        location?.description = newValue
    }
    
    func priceChanged(_ newValue: String?) {
        guard let newValue = newValue, let price = Double(newValue) else { return }
        location?.price = price
    }
    
    func latitudeChanged(_ newValue: Double?) {
        guard let newValue = newValue else { return }
        location?.latitude = newValue
    }
    
    func longitudeChanged(_ newValue: Double?) {
        guard let newValue = newValue else { return }
        location?.longitude = newValue
    }
    
    func handlePost() {
        location?.images = ["https://s3.eu-central-1.amazonaws.com/octaviansuniversalbucket/Room1.jpg", "https://s3.eu-central-1.amazonaws.com/octaviansuniversalbucket/Room2.jpg"]
        location?.userID = AuthService.shared.user.id
        
        guard let location = location else { return }
        
        SocketService.shared.addLocation(location) { [weak self] (success) in
            guard let weakSelf = self else { return }
            weakSelf.view?.navigateToAccommodationScreen()
        }
    }
    
    func delayMapAnimation() {
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + Constants.delay) { [weak self] in
            guard let weakSelf = self else { return }
            weakSelf.view?.minimizeMap()
        }
    }
}

extension AddAccommodationPresenter: CLLocationManagerDelegate {
    
    func configureLocationServices() {
        if authorizationStatus == .notDetermined {
            locationManager.requestAlwaysAuthorization()
        } else {
            return
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        view?.centerMapOnUserLocation(withLatitude: userCoordinates.latitude, andLongitude: userCoordinates.longitude)
    }
}
