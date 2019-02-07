//
//  AlbumViewController+MKMapViewDelegate.swift
//  Virtual Tourist
//
//  Created by Felipe Ribeiro on 07/02/19.
//  Copyright © 2019 Felipe Ribeiro. All rights reserved.
//

import MapKit

extension AlbumViewController: MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        let reuseIdentifier = "LocationMarker"
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseIdentifier) as? MKMarkerAnnotationView
        
        if annotationView == nil {
            annotationView = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: reuseIdentifier)
        } else {
            annotationView!.annotation = annotation
        }
        
        annotationView!.isEnabled = false
        annotationView!.animatesWhenAdded = true
        annotationView!.clusteringIdentifier = nil
        annotationView!.canShowCallout = false
        annotationView!.markerTintColor = UIColor(named: "Primary Yellow")!
        annotationView!.glyphImage = UIImage(named: "Album (marker)")!
        annotationView!.glyphTintColor = .black
        
        return annotationView
    }
}
