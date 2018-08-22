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
    
    private lazy var queue: OperationQueue = {
        let queue = OperationQueue()
        queue.maxConcurrentOperationCount = 1
        return queue
    }()
    
    init(view: AddAccommodationView) {
        self.view = view
    }
    
    func viewDidLoad() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        
        StorageService.shared.setupProvider()
        configureLocationServices()
        view?.centerMapOnUserLocation(withLatitude: userCoordinates.latitude, andLongitude: userCoordinates.longitude)
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
    
    func handlePost(withData data: [Data]) {
        
        for item in data {
            let imageName = NSUUID().uuidString + ".jpg"
            
            let imageUploadOperation = UploadImageOperation(imageName: imageName, imageData: item)
            imageUploadOperation.onDidUpload = { [weak self] in
                guard let weakSelf = self else { return }
                weakSelf.location?.images.append("\(Route.baseAWS)/\(imageName)")
            }
            
            if let lastOperation = queue.operations.last {
                imageUploadOperation.addDependency(lastOperation)
            }
            
            queue.addOperation(imageUploadOperation)
        }
        
        let finishOperation = BlockOperation { [weak self] in
            guard let weakSelf = self else { return }
            weakSelf.location?.userID = AuthService.shared.user.id
            
            guard let location = weakSelf.location else { return }
            
            SocketService.shared.addLocation(location) { [weak self] (success) in
                guard let _ = self else { return }
                
                if success {
                    DispatchQueue.main.async { [weak self] in
                        guard let weakSelf = self else { return }
                        weakSelf.view?.navigateToAccommodationScreen()
                    }
                }
            }
        }
        if let lastOperation = queue.operations.last {
            finishOperation.addDependency(lastOperation)
        }
        queue.addOperation(finishOperation)
        
        queue.isSuspended = false
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
