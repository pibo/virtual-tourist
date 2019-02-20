//
//  AlbumViewController+NSFetchedResultsControllerDelegate.swift
//  Virtual Tourist
//
//  Created by Felipe Ribeiro on 13/02/19.
//  Copyright © 2019 Felipe Ribeiro. All rights reserved.
//

import Foundation
import CoreData

extension AlbumViewController: NSFetchedResultsControllerDelegate {
    
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        deleteOperations.removeAll(keepingCapacity: false)
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        switch type {
        case .update: photoCollection.reloadItems(at: [indexPath!])
        case .delete:
            let operation = BlockOperation { self.photoCollection.deleteItems(at: [indexPath!]) }
            deleteOperations.append(operation)
        default: break
        }
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        if !deleteOperations.isEmpty {
            photoCollection.performBatchUpdates({
                self.deleteOperations.forEach { $0.start() }
            }, completion: { _ in
                self.deleteOperations.removeAll(keepingCapacity: false)
            })
        }
    }
}
