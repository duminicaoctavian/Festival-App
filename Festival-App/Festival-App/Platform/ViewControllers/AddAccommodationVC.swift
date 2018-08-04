//
//  AddAccommodationVC.swift
//  Festival-App
//
//  Created by Octavian Duminica on 31/07/2018.
//  Copyright © 2018 Duminica Octavian. All rights reserved.
//

import Foundation
import MapKit
import CoreLocation


private struct Constants {
    static let regionRadius: Double = 500
    static let mapHeight: CGFloat = 150
    static let offerTitleLabelTopConstraint: CGFloat = 19.5
    static let descriptionTextViewPlaceholder = "Description"
    static let placeholderColor = UIColor.lightGray
    static let descriptionTextFieldHeightConstraint: CGFloat = 36.5
    static let pinAsset = "pin"
}

class AddAccommodationVC: UIViewController {
    
    @IBOutlet weak var mapViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var offerTitleTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var descriptionTextViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var offerTitleTextField: UITextField!
    @IBOutlet weak var addressTextField: UITextField!
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var priceTextField: UITextField!
    @IBOutlet weak var mapErrorLabel: UILabel!
    
    var location: Location!
    
    lazy var singleTap: UITapGestureRecognizer = {
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleSingleTap))
        return tap
    }()
    
    lazy var longPress: UILongPressGestureRecognizer = {
        let longPress = UILongPressGestureRecognizer(target: self, action: #selector(dropPin(sender:)))
        longPress.minimumPressDuration = 0.5
        return longPress
    }()
    
    func addLongPress() {
        mapView.addGestureRecognizer(longPress)
    }
    
    func removeLongPress() {
        mapView.removeGestureRecognizer(longPress)
    }
    
    func removeSingleTap() {
        mapView.removeGestureRecognizer(singleTap)
    }
    
    func addSingleTap() {
        mapView.addGestureRecognizer(singleTap)
    }
    
    var isMapExpanded = false
    var locationManager = CLLocationManager()
    let authorizationStatus = CLLocationManager.authorizationStatus()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        scrollView.keyboardDismissMode = .onDrag
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        mapView.showsUserLocation = true
        
        addSingleTap()
        setupDelegates()
        configureLocationServices()
        hideKeyboardWhenTappedAround()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        location = Location()
        isMapExpanded = false
        setupKeyboardObservers()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self)
    }
    
    var keyboardDidScroll = false
    
    private func setupKeyboardObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    private func handleKeyboard(view: UIView, keyboardFrame: CGRect) {
        let minXminYPoint = CGPoint(x: view.frame.minX, y: view.frame.minY)
        
        let viewCoordinates = scrollView.convert(minXminYPoint, to: nil)
        if viewCoordinates.y >= keyboardFrame.minY {
            scrollView.contentOffset = CGPoint(x: 0, y: scrollView.contentOffset.y + keyboardFrame.height)
            keyboardDidScroll = true
        }
    }
    
    private func setupDelegates() {
        descriptionTextView.delegate = self
        mapView.delegate = self
        locationManager.delegate = self
        offerTitleTextField.delegate = self
        addressTextField.delegate = self
        priceTextField.delegate = self
    }
    
    @objc func handleKeyboardWillHide(notification: Notification) {
        guard let keyboardFrame = (notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else {
            return
        }
        if keyboardDidScroll {
            scrollView.contentOffset = CGPoint(x: 0, y: scrollView.contentOffset.y - keyboardFrame.height)
        }
        keyboardDidScroll = false
    }
    
    @objc func handleKeyboardWillShow(notification: Notification) {
        guard let keyboardFrame = (notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else {
            return
        }
        
        if priceTextField.isFirstResponder {
            handleKeyboard(view: priceTextField, keyboardFrame: keyboardFrame)
        } else if descriptionTextView.isFirstResponder {
            handleKeyboard(view: descriptionTextView, keyboardFrame: keyboardFrame)
        } else if addressTextField.isFirstResponder {
            handleKeyboard(view: addressTextField, keyboardFrame: keyboardFrame)
        } else if offerTitleTextField.isFirstResponder {
            handleKeyboard(view: offerTitleTextField, keyboardFrame: keyboardFrame)
        }
    }
    
    @IBAction func onBackTapped(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    @objc func handleSingleTap() {
        addLongPress()
        removeSingleTap()
        isMapExpanded = true
        mapViewHeightConstraint.constant = mapView.frame.width
        
        UIView.animate(withDuration: 0.3, delay: 0.0, options: .curveEaseIn, animations: {
            self.view.layoutIfNeeded()
        }, completion: nil)
    }
    
    @IBAction func onPostTapped(_ sender: Any) {
        location?.title = offerTitleTextField.text!
        location?.address = addressTextField.text!
        location?.description = descriptionTextView.text
        location?.price = Double(priceTextField.text!)!
        location?.images = ["https://s3.eu-central-1.amazonaws.com/octaviansuniversalbucket/Room1.jpg", "https://s3.eu-central-1.amazonaws.com/octaviansuniversalbucket/Room2.jpg"]
        location?.userID = ""
        SocketService.instance.addLocation(location!) { (success) in
            print("Location sent to server")
        }
    }
}

extension AddAccommodationVC: MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if !(annotation is MKPointAnnotation) {
            return nil
        }
        
        let annotationIdentifier = "droppablePin"
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: annotationIdentifier)
        
        if annotationView == nil {
            annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: annotationIdentifier)
            annotationView?.canShowCallout = true
        } else {
            annotationView?.annotation = annotation
        }
        
        let pinImage = UIImage(named: Constants.pinAsset)
        annotationView?.image = pinImage
        
        return annotationView
        
    }
    
    @objc func dropPin(sender: UILongPressGestureRecognizer) {
        let touchPoint = sender.location(in: mapView)
        let touchCoordinate = mapView.convert(touchPoint, toCoordinateFrom: mapView)
        location?.latitude = touchCoordinate.latitude
        location?.longitude = touchCoordinate.longitude
        
        let annotation = MKPointAnnotation()
        annotation.coordinate = CLLocationCoordinate2DMake(touchCoordinate.latitude, touchCoordinate.longitude)
        annotation.title = "Your offer location"
        
        let annotations = mapView.annotations
        self.mapView.removeAnnotations(annotations)
        self.mapView.addAnnotation(annotation)
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.6) {
            self.minimizeMap()
        }
    }
    
    private func minimizeMap() {
        isMapExpanded = false
        mapViewHeightConstraint.constant = Constants.mapHeight
        
        UIView.animate(withDuration: 0.3, delay: 0.0, options: .curveEaseOut, animations: {
            self.view.layoutIfNeeded()
        }, completion: nil)
        
        addSingleTap()
    }
    
    private func centerMapOnUserLocation() {
        guard let coordinate = locationManager.location?.coordinate else { return }
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(coordinate, Constants.regionRadius*2, Constants.regionRadius*2)
        mapView.setRegion(coordinateRegion, animated: true)
    }
}

extension AddAccommodationVC: CLLocationManagerDelegate {
    
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

extension AddAccommodationVC: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        minimizeMap()
    }
}

extension AddAccommodationVC: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.text == Constants.descriptionTextViewPlaceholder {
            textView.text = ""
        }
        textView.textColor = .black
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text == "" {
            textView.text = Constants.descriptionTextViewPlaceholder
            if textView.text == "Description" {
                textView.textColor = Constants.placeholderColor
            } else {
                textView.textColor = .black
            }
        }
    }
    
    func textViewDidChange(_ textView: UITextView) {
        let size = CGSize(width: descriptionTextView.frame.width, height: .infinity)
        let estimatedSize = textView.sizeThatFits(size)
        descriptionTextViewHeightConstraint.constant = estimatedSize.height
    }
}



