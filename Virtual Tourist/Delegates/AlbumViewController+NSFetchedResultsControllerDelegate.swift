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
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        switch type {
        case .update: photoCollection.reloadItems(at: [indexPath!])
        default: break
        }
    }
}
