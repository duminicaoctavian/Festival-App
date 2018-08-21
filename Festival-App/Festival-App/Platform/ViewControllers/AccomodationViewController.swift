//
//  AccomodationVC.swift
//  Festival-App
//
//  Created by Duminica Octavian on 24/02/2018.
//  Copyright © 2018 Duminica Octavian. All rights reserved.
//

import UIKit
import MapKit

private struct Constants {
    static let span = 0.01
    static let pinAssetName = "pinSmall"
}

class AccomodationViewController: UIViewController {
    
    lazy var presenter: AccommodationPresenter = {
        return AccommodationPresenter(view: self)
    }()

    @IBOutlet weak var menuButton: UIButton!
    @IBOutlet weak var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSlideMenu()
        hideNavigationBar()
        presenter.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter.viewWillAppear()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        presenter.viewWillDisappear()
    }
    
    @IBAction func centerButtonTapped(_ sender: Any) {
        presenter.handleAuthorizationStatus()
    }
}

extension AccomodationViewController : MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if annotation is MKUserLocation {
            return nil
        }
        
        let annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: MapPin.className)
        annotationView.image = UIImage(named: Constants.pinAssetName)
        return annotationView
    }
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        if let mapPin = view.annotation as? MapPin {
            mapView.deselectAnnotation(mapPin, animated: false)
            navigateToLocationDetailsScreen(forLocation: mapPin.location)
        }
    }
}

extension AccomodationViewController: AccommodationView {
    func setupSlideMenu() {
        menuButton.addTarget(revealViewController(), action: #selector(SWRevealViewController.revealToggle(_:)), for: .touchUpInside)
        view.addGestureRecognizer(revealViewController().panGestureRecognizer())
        view.addGestureRecognizer(revealViewController().tapGestureRecognizer())
    }
    
    func hideNavigationBar() {
        navigationController?.navigationBar.isHidden = true
    }
    
    func centerMapOnUserLocation(withLatitude latitude: Double, andLongitude longitude: Double) {
        let region = MKCoordinateRegion(latitude: latitude, longitude: longitude, latitudeDelta: Constants.span, longitudeDelta: Constants.span)
        mapView.setRegion(region, animated: true)
    }
    
    func displayAnnotation(_ annotation: MapPin) {
        mapView.addAnnotation(annotation)
    }
    
    func navigateToLocationDetailsScreen(forLocation location: Location) {
        let locationDetailsViewController = LocationDetailsViewController()
        locationDetailsViewController.presenter.locationChanged(location)
        locationDetailsViewController.modalPresentationStyle = .custom
        present(locationDetailsViewController, animated: true, completion: nil)
    }
}

