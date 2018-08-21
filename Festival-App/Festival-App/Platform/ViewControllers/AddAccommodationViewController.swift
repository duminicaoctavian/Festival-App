//
//  AddAccommodationViewController.swift
//  Festival-App
//
//  Created by Octavian Duminica on 31/07/2018.
//  Copyright © 2018 Duminica Octavian. All rights reserved.
//

import UIKit
import MapKit

private struct Constants {
    static let span = 0.01
    static let mapHeight: CGFloat = 150
    static let offerTitleLabelTopConstraint: CGFloat = 19.5
    static let descriptionTextFieldHeightConstraint: CGFloat = 36.5
    static let placeholderText = "Description"
    static let pinAssetName = "pin"
    static let placeholderColor = UIColor.lightGray
    static let longPressDuration = 0.5
    static let mapViewAnimationDuration = 0.3
}

class AddAccommodationViewController: UIViewController {
    
    lazy var presenter: AddAccommodationPresenter = {
        return AddAccommodationPresenter(view: self)
    }()
    
    lazy var singleTap: UITapGestureRecognizer = {
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleSingleTap))
        return tap
    }()
    
    lazy var longPress: UILongPressGestureRecognizer = {
        let longPress = UILongPressGestureRecognizer(target: self, action: #selector(dropPin(sender:)))
        longPress.minimumPressDuration = Constants.longPressDuration
        return longPress
    }()
    
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
    
    var isMapExpanded = false
    var keyboardDidScroll = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hideKeyboardWhenTappedAround()
        addSingleTapToMapView()
        presenter.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        isMapExpanded = false
        setupKeyboardObservers()
        presenter.viewWillAppear()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        removeKeyboardObservers()
    }
    
    @IBAction func onBackTapped(_ sender: Any) {
        navigateToAccommodationScreen()
    }
    
    @IBAction func onPostTapped(_ sender: Any) {
        presenter.titleChanged(offerTitleTextField.text)
        presenter.addressChanged(addressTextField.text)
        presenter.descriptionChanged(descriptionTextView.text)
        presenter.priceChanged(priceTextField.text)
        presenter.handlePost()
    }
    
    private func addLongPressToMapView() {
        mapView.addGestureRecognizer(longPress)
    }
    
    private func removeLongPressFromMapView() {
        mapView.removeGestureRecognizer(longPress)
    }
    
    private func removeSingleTapFromMapView() {
        mapView.removeGestureRecognizer(singleTap)
    }
    
    private func addSingleTapToMapView() {
        mapView.addGestureRecognizer(singleTap)
    }
    
    private func setupKeyboardObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    private func removeKeyboardObservers() {
        NotificationCenter.default.removeObserver(self)
    }
    
    private func handleKeyboard(view: UIView, keyboardFrame: CGRect) {
        let minXminYPoint = CGPoint(x: view.frame.minX, y: view.frame.minY)
        
        let viewCoordinates = scrollView.convert(minXminYPoint, to: nil)
        if viewCoordinates.y >= keyboardFrame.minY {
            scrollView.contentOffset = CGPoint(x: 0, y: scrollView.contentOffset.y + keyboardFrame.height)
            keyboardDidScroll = true
        }
    }
    
    private func removeMapViewAnnotations() {
        let annotations = mapView.annotations
        mapView.removeAnnotations(annotations)
    }
    
    // TODO - Separate CoreLocation from MapKit
    @objc func dropPin(sender: UILongPressGestureRecognizer) {
        let point = sender.location(in: mapView)
        let coordinate = mapView.convert(point, toCoordinateFrom: mapView)
        
        presenter.latitudeChanged(coordinate.latitude)
        presenter.longitudeChanged(coordinate.longitude)
        
        let annotation = MKPointAnnotation()
        annotation.coordinate = CLLocationCoordinate2DMake(coordinate.latitude, coordinate.longitude)
        
        removeMapViewAnnotations()
        mapView.addAnnotation(annotation)
        
        presenter.delayMapAnimation()
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
        minimizeMap()
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
    
    @objc func handleSingleTap() {
        addLongPressToMapView()
        removeSingleTapFromMapView()
        mapViewHeightConstraint.constant = mapView.frame.width
        isMapExpanded = true
        view.endEditing(true)
        
        UIView.animate(withDuration: Constants.mapViewAnimationDuration, delay: 0.0, options: .curveEaseIn, animations: { [weak self] in
            guard let weakSelf = self else { return }
            weakSelf.view.layoutIfNeeded()
            }, completion: nil)
    }
}

extension AddAccommodationViewController: MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if annotation is MKUserLocation {
            return nil
        }
        
        let annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: MapPin.className)
        annotationView.image = UIImage(named: Constants.pinAssetName)
        return annotationView
    }
}

extension AddAccommodationViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        minimizeMap()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return true
    }
}

extension AddAccommodationViewController: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.text == Constants.placeholderText {
            textView.text = ""
        }
        textView.textColor = .black
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text == "" {
            textView.text = Constants.placeholderText
            textView.textColor = Constants.placeholderColor
        }
    }
    
    func textViewDidChange(_ textView: UITextView) {
        let size = CGSize(width: descriptionTextView.frame.width, height: .infinity)
        let estimatedSize = textView.sizeThatFits(size)
        descriptionTextViewHeightConstraint.constant = estimatedSize.height
    }
}

extension AddAccommodationViewController: AddAccommodationView {
    func centerMapOnUserLocation(withLatitude latitude: Double, andLongitude longitude: Double) {
        let region = MKCoordinateRegion(latitude: latitude, longitude: longitude, latitudeDelta: Constants.span, longitudeDelta: Constants.span)
        mapView.setRegion(region, animated: true)
    }
    
    func setupScrollView() {
        scrollView.keyboardDismissMode = .onDrag
    }
    
    func minimizeMap() {
        isMapExpanded = false
        mapViewHeightConstraint.constant = Constants.mapHeight
        
        UIView.animate(withDuration: Constants.mapViewAnimationDuration, delay: 0.0, options: .curveEaseOut, animations: { [weak self] in
            guard let weakSelf = self else { return }
            weakSelf.view.layoutIfNeeded()
        }, completion: nil)
        
        addSingleTapToMapView()
    }
    
    func navigateToAccommodationScreen() {
        navigationController?.popViewController(animated: true)
    }
}
