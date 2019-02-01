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
        switch type {
        case .insert:
            let location = anObject as! Location
            let annotation = LocationMarker(location)
            mapView.addAnnotation(annotation)
        default: break
        }
    }
}
