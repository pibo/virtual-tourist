//
//  AlbumViewController.swift
//  Virtual Tourist
//
//  Created by Felipe Ribeiro on 07/02/19.
//  Copyright © 2019 Felipe Ribeiro. All rights reserved.
//

import UIKit
import CoreLocation
import CoreData

class AlbumViewController: UIViewController {

    // MARK: - Properties
    
    let distanceSpan: CLLocationDistance = 20000.0
    let photoCollectionSpacing: CGFloat = 4.0
    let context = DataController.shared.viewContext
    var fetchedResultsController: NSFetchedResultsController<Photo>!
    var location: Location!
    
    var isLoading: Bool = false {
        didSet {
            activityIndicator.isHidden = !isLoading
            photoCollection.isHidden = isLoading
        }
    }
    
    // MARK: - Computed Properties
    
    var photos: [Photo] {
        return fetchedResultsController.fetchedObjects!
    }
    
    // MARK: - Outlets
    
    @IBOutlet var photoCollection: UICollectionView!
    @IBOutlet var activityIndicator: UIActivityIndicatorView!
    
    // MARK: - Life Cycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupFetchedResultsController()
        
        if photos.count == 0 {
            isLoading = true
            refresh { self.isLoading = false }
        }
    }
    
    // MARK: - Helper Methods

    func setupFetchedResultsController() {
        let request: NSFetchRequest<Photo> = Photo.fetchRequest()
        let predicate = NSPredicate(format: "location == %@", location)
        let byDate = NSSortDescriptor(key: "createdAt", ascending: false)
        
        request.predicate = predicate
        request.sortDescriptors = [byDate]
        
        fetchedResultsController = NSFetchedResultsController(
            fetchRequest: request,
            managedObjectContext: self.context,
            sectionNameKeyPath: nil,
            cacheName: nil
        )
        
        fetchedResultsController.delegate = self
        
        do {
            try fetchedResultsController.performFetch()
        } catch {
            fatalError("The saved locations couldn't be loaded: \(error.localizedDescription)")
        }
    }
    
    func refresh(completion: @escaping () -> Void) {
        Flickr.search(latitude: location.latitude, longitude: location.longitude, page: Int(location.page)) { response, error in
            guard let response = response else {
                completion()
                return
            }
            
            response.photos.forEach {
                let _ = Photo(fromFlickr: $0, location: self.location, context: self.context)
            }
            
            // Go to the next page.
            self.location.page += 1
            
            try? self.context.save()
            self.photoCollection.reloadData()
            
            completion()
        }
    }
}
