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
        if mode == .none {
            UserDefaults.standard.removeObject(forKey: UserDefaultsKeys.userTrackingMode)
        } else {
            UserDefaults.standard.set(mode.rawValue, forKey: UserDefaultsKeys.userTrackingMode)
        }
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        let reuseIdentifier = "LocationMarker"
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseIdentifier) as? MKMarkerAnnotationView
        
        if annotationView == nil {
            annotationView = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: reuseIdentifier)
        } else {
            annotationView!.annotation = annotation
        }
        
        annotationView!.animatesWhenAdded = true
        annotationView!.clusteringIdentifier = nil
        annotationView!.canShowCallout = true
        annotationView!.markerTintColor = UIColor(named: "Primary Yellow")!
        annotationView!.glyphImage = UIImage(named: "Album (marker)")!
        annotationView!.glyphTintColor = .black
        
        return annotationView
    }
}
