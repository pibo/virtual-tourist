//
//  MapViewController+NSFetchedResultsControllerDelegate.swift
//  Virtual Tourist
//
//  Created by Felipe Ribeiro on 01/02/19.
//  Copyright © 2019 Felipe Ribeiro. All rights reserved.
//

import Foundation
import CoreData

extension MapViewController: NSFetchedResultsControllerDelegate {
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        let location = anObject as! Location
        switch type {
            
        case .insert:
            let annotation = LocationAnnotation(location)
            mapView.deselectAnnotation(mapView.selectedAnnotations.first, animated: true)
            mapView.addAnnotation(annotation)
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
                self.mapView.selectAnnotation(annotation, animated: true)
            }
            
        case .update:
            detailCallout.setPhotoCount(location.photos!.count)
            
        case .delete:
            if let annotation = getAnnotation(for: location) {
                mapView.removeAnnotation(annotation)
            }
            
        default: break
        }
    }
}
