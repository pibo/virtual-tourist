//
//  LocationMarker.swift
//  Virtual Tourist
//
//  Created by Felipe Ribeiro on 01/02/19.
//  Copyright © 2019 Felipe Ribeiro. All rights reserved.
//

import MapKit
import CoreLocation

class LocationAnnotation: NSObject, MKAnnotation {
    
    let title: String?
    let subtitle: String?
    let coordinate: CLLocationCoordinate2D
    let location: Location
    
    init(_ location: Location) {
        title = location.title
        subtitle = location.country
        coordinate = CLLocationCoordinate2DMake(location.latitude, location.longitude)
        self.location = location
    }
}
