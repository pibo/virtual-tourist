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
        
        if annotation is MKUserLocation {
            return nil
        }
        
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
        
        // Configure the detail callout view.
        detailCallout.deleteButton.addTarget(self, action: #selector(deleteTapped(_:)), for: .touchUpInside)
        detailCallout.albumButton.addTarget(self, action: #selector(albumTapped(_:)), for: .touchUpInside)
        
        annotationView!.detailCalloutAccessoryView = detailCallout
        
        return annotationView
    }
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        // Disable for the current user location.
        guard view != mapView.view(for: mapView.userLocation) else { return }
        
        let annotation = view.annotation as! LocationAnnotation
        detailCallout.subtitleLabel.text = annotation.subtitle!
        detailCallout.setPhotoCount(annotation.location.photos?.count ?? 0)
    }
    
    // Disable callout for the user location.
    func mapViewDidFinishLoadingMap(_ mapView: MKMapView) {
        if let view = mapView.view(for: mapView.userLocation) {
            view.canShowCallout = false
        }
    }
}
