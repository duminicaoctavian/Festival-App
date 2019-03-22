//
//  AccommodationPresenter.swift
//  Festival-App
//
//  Created by Octavian Duminica on 21/08/2018.
//  Copyright © 2018 Duminica Octavian. All rights reserved.
//

import Foundation
import CoreLocation

class AccommodationPresenter: NSObject {
    weak var view: AccommodationView?
    
    var locationManager = CLLocationManager()
    
    var userCoordinates: (latitude: Double, longitude: Double) {
        guard let coordinate = locationManager.location?.coordinate else { return (0, 0) }
        return (coordinate.latitude, coordinate.longitude)
    }
    
    let authorizationStatus = CLLocationManager.authorizationStatus()
    
    init(view: AccommodationView) {
        self.view = view
    }
    
    func viewDidLoad() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        
        configureLocationServices()
        view?.centerMapOnUserLocation(withLatitude: userCoordinates.latitude, andLongitude: userCoordinates.longitude)
    }
    
    func viewWillAppear() {
        getAllLocations()
        
        observeLocationCreated()
        observeLocationDeleted()
        observeLocationUpdated()
    }
    
    func viewWillDisappear() {
        LocationService.shared.clearLocations()
        removeListeners()
    }
    
    func handleAuthorizationStatus() {
        if authorizationStatus == .authorizedAlways || authorizationStatus == .authorizedWhenInUse {
            view?.centerMapOnUserLocation(withLatitude: userCoordinates.latitude, andLongitude: userCoordinates.longitude)
        }
    }
    
    private func observeLocationCreated() {
        SocketService.shared.getCreatedLocation { [weak self] (newLocation) in
            guard let weakSelf = self else { return }
            
            if let location = newLocation {
                let coordinate = CLLocationCoordinate2D(latitude: location.latitude, longitude: location.longitude)
                
                let mapPin = MapPin(coordinate: coordinate, identifier: MapPin.className, location: location)
                
                weakSelf.view?.displayAnnotation(mapPin)
            }
        }
    }
    
    private func observeLocationDeleted() {
        SocketService.shared.getDeletedLocation { (_) in
        }
    }
    
    private func observeLocationUpdated() {
        SocketService.shared.getUpdatedLocation { (_) in
        }
    }
    
    private func getAllLocations() {
        LocationService.shared.getAllLocations { [weak self] (success) in
            guard let weakSelf = self else { return }
            
            if success {
                LocationService.shared.locations.forEach({ (location) in
                    
                    let coordinate = CLLocationCoordinate2DMake(location.latitude, location.longitude)
                    
                    let mapPin = MapPin(coordinate: coordinate, identifier: MapPin.className, location: location)

                    weakSelf.view?.displayAnnotation(mapPin)
                })
            }
        }
    }
    
    private func removeListeners() {
        SocketService.shared.removeListener(forEvent: Event.locationCreated)
        SocketService.shared.removeListener(forEvent: Event.locationDeleted)
        SocketService.shared.removeListener(forEvent: Event.locationUpdated)
    }
}

extension AccommodationPresenter: CLLocationManagerDelegate {
    
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
