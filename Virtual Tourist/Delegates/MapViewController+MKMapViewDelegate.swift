//
//  MapViewController+MKMapViewDelegate.swift
//  Virtual Tourist
//
//  Created by Felipe Ribeiro on 31/01/19.
//  Copyright © 2019 Felipe Ribeiro. All rights reserved.
//

import MapKit
import CoreLocation

extension MapViewController: MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, didChange mode: MKUserTrackingMode, animated: Bool) {
        
        // Ask for the user permission in the first time the user changes his tracking mode.
        let authorization = CLLocationManager.authorizationStatus()
        if authorization != .authorizedWhenInUse {
            locationManager.requestWhenInUseAuthorization()
        }
        
        // Persist the tracking mode.
        UserDefaults.standard.set(mode.rawValue, forKey: UserDefaultsKeys.userTrackingMode)
    }
}