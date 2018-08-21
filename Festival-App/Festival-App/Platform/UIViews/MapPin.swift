//
//  MapPin.swift
//  Festival-App
//
//  Created by Octavian on 09/01/2018.
//  Copyright © 2018 Octavian. All rights reserved.
//

import UIKit
import MapKit

class MapPin: NSObject, MKAnnotation {
    dynamic var coordinate: CLLocationCoordinate2D
    var identifier: String
    var location: Location
    
    init(coordinate: CLLocationCoordinate2D, identifier: String, location: Location) {
        self.coordinate = coordinate
        self.identifier = identifier
        self.location = location
        super.init()
    }
}
