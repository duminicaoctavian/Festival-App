//
//  MapPin.swift
//  pixel-city
//
//  Created by Octavian on 09/01/2018.
//  Copyright © 2018 Octavian. All rights reserved.
//

import UIKit
import MapKit

class MapPin : NSObject, MKAnnotation {
    dynamic var coordinate: CLLocationCoordinate2D //dynamic variables are able to be modified the way we need to to create these MKAnnotations
    var identifier: String
    var locationTitle: String
    var locationAddress: String
    var locationDescription: String
    var locationImages = [String]()
    
    init(coordinate: CLLocationCoordinate2D, identifier: String, locationTitle: String, locationAddress: String, locationDescription: String, locationImages: [String]) {
        self.coordinate = coordinate
        self.identifier = identifier
        self.locationTitle = locationTitle
        self.locationAddress = locationAddress
        self.locationDescription = locationDescription
        self.locationImages = locationImages
        super.init()
    }
}
