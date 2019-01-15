//
//  MKCoordinateRegionExtensions.swift
//  Festival-App
//
//  Created by Octavian Duminica on 21/08/2018.
//  Copyright © 2018 Duminica Octavian. All rights reserved.
//

import Foundation
import MapKit

extension MKCoordinateRegion {
    init(latitude: Double, longitude: Double, latitudeDelta: Double, longitudeDelta: Double) {
        self.init()
        self.center = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        self.span = MKCoordinateSpan(latitudeDelta: latitudeDelta, longitudeDelta: longitudeDelta)
    }
}
