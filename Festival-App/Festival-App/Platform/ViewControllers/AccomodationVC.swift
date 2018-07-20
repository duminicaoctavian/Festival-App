//
//  AccomodationVC.swift
//  Festival-App
//
//  Created by Duminica Octavian on 24/02/2018.
//  Copyright © 2018 Duminica Octavian. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class AccomodationVC: UIViewController {
    
    var locationManager = CLLocationManager()
    
    let authorizationStatus = CLLocationManager.authorizationStatus()
    let regionRadius: Double = 500

    @IBOutlet weak var menuBtn: UIButton!
    @IBOutlet weak var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpSWRevealViewController()
        mapView.delegate = self
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        mapView.showsUserLocation = true
        configureLocationServices()
        centerMapOnUserLocation()
        
        addTap()
        
        SocketService.instance.getMapLocation { (newLocation) in
            if newLocation._id != nil {
                let locCoord = CLLocationCoordinate2D(latitude: Double(newLocation.latitude), longitude: Double(newLocation.longitude))
                
                let annotation = MapPin(coordinate: locCoord, identifier: "locPin", locationTitle: newLocation.title, locationAddress: newLocation.address, locationDescription: newLocation.description, locationImages: newLocation.images)
                
                self.mapView.addAnnotation(annotation)
            }
        }
        
        LocationService.instance.findAllLocations { (success) in
            if success {
                LocationService.instance.locations.forEach({ (location) in
                    let locCoord = CLLocationCoordinate2D(latitude: Double(location.latitude), longitude: Double(location.longitude))
                    
                    let annotation = MapPin(coordinate: locCoord, identifier: "locPin", locationTitle: location.title!, locationAddress: location.address!, locationDescription: location.description, locationImages: location.images!)
                    self.mapView.addAnnotation(annotation)
                })
            }
        }
    }
    
    func setUpSWRevealViewController() {
        
        menuBtn.addTarget(self.revealViewController(), action: #selector(SWRevealViewController.revealToggle(_:)), for: .touchUpInside)
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        self.view.addGestureRecognizer(self.revealViewController().tapGestureRecognizer())
    }
    
    
    
    func addTap() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(dropPin(sender: )))
        tap.numberOfTapsRequired = 2
        mapView.addGestureRecognizer(tap)
    }
    
    @IBAction func centerBtnWasPressed(_ sender: Any) {
        if authorizationStatus == .authorizedAlways || authorizationStatus == .authorizedWhenInUse {
            centerMapOnUserLocation()
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        LocationService.instance.clearLocation()
    }
}

extension AccomodationVC : MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if annotation is MKUserLocation {
            return nil
        }
        
        let pinAnnotation = MKPinAnnotationView(annotation: annotation, reuseIdentifier: "droppablePin")
        pinAnnotation.pinTintColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
        pinAnnotation.animatesDrop = true
        return pinAnnotation
    }
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        let location = view.annotation as! MapPin
        let pinDetailsVC = PinDetailsVC()
        pinDetailsVC.locationTitle = location.locationTitle
        pinDetailsVC.locationAddress = location.locationAddress
        pinDetailsVC.locationDescription = location.locationDescription
        pinDetailsVC.locationImages = location.locationImages
        pinDetailsVC.modalPresentationStyle = .custom
        self.present(pinDetailsVC, animated: true, completion: nil)
    }
    
    func centerMapOnUserLocation() {    
        guard let coordinate = locationManager.location?.coordinate else { return } //if there is no value, return
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(coordinate, regionRadius*2, regionRadius*2)
        mapView.setRegion(coordinateRegion, animated: true)
    }
    
    @objc func dropPin(sender: UITapGestureRecognizer) {
        
        let touchPoint = sender.location(in: mapView)
        let touchCoordinate = mapView.convert(touchPoint, toCoordinateFrom: mapView)
        
        SocketService.instance.addLocation(latitude: String(touchCoordinate.latitude), longitude: String(touchCoordinate.longitude), userId: AuthService.instance.id, title: "Good place for rent!", address: "Str. Placeholder nr. 24", description: "This is a placeholder", images: ["https://s3.eu-central-1.amazonaws.com/octaviansuniversalbucket/Room1.jpg", "https://s3.eu-central-1.amazonaws.com/octaviansuniversalbucket/Room2.jpg"]) { (success) in
            if success {
                print("SENT LOCATION TO SERVER")
            }
        }
        
        print(touchCoordinate.latitude)
        print(touchCoordinate.longitude)
        
    }
}

extension AccomodationVC : CLLocationManagerDelegate {
    
    func configureLocationServices() {
        if authorizationStatus == .notDetermined {
            locationManager.requestAlwaysAuthorization()
        } else {
            return
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        centerMapOnUserLocation()
    }
}

