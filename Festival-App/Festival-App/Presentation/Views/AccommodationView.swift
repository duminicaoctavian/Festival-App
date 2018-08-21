//
//  AccommodationView.swift
//  Festival-App
//
//  Created by Octavian Duminica on 21/08/2018.
//  Copyright © 2018 Duminica Octavian. All rights reserved.
//

import Foundation

protocol AccommodationView: class {
    func setupSlideMenu()
    func hideNavigationBar()
    func centerMapOnUserLocation(withLatitude latitude: Double, andLongitude longitude: Double)
    func displayAnnotation(_ annotation: MapPin)
}
