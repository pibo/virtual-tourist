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
    let activityIndicatorButtonItem: UIBarButtonItem = {
        var activityIndicator = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
        activityIndicator.color = UIColor(named: "Primary Yellow")!
        activityIndicator.startAnimating()
        
        return UIBarButtonItem(customView: activityIndicator)
    }()
    
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
    @IBOutlet var refreshButtonItem: UIBarButtonItem!
    
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
            
            self.deleteCurrentAlbum()
            
            response.photos.forEach {
                let _ = Photo(fromFlickr: $0, location: self.location, context: self.context)
            }
            
            // Increase the location page to grab fresh photos from Flickr's next page.
            self.location.page += 1
            
            try? self.context.save()
            self.photoCollection.reloadData()
            
            self.downloadImagesInBackground()
            
            completion()
        }
    }
    
    func downloadImagesInBackground() {
        let noImage: (Photo) -> Bool = { $0.image == nil }
        photos.filter(noImage).forEach { photo in
            DataController.shared.persistentContainer.performBackgroundTask { context in
                let backgroundPhoto = context.object(with: photo.objectID) as! Photo
                if let image = try? Data(contentsOf: backgroundPhoto.url!) {
                    backgroundPhoto.image = image
                    try? context.save()
                }
            }
        }
    }
    
    func deleteCurrentAlbum() {
        photos.forEach { context.delete($0) }
    }
    
    // MARK: - Actions
    
    @IBAction func refresh(_ sender: Any) {
        var rightBarButtonItems = navigationItem.rightBarButtonItems!.replacing(refreshButtonItem, with: activityIndicatorButtonItem)
        navigationItem.setRightBarButtonItems(rightBarButtonItems, animated: true)
        
        refresh {
            rightBarButtonItems = self.navigationItem.rightBarButtonItems!.replacing(self.activityIndicatorButtonItem, with: self.refreshButtonItem)
            self.navigationItem.setRightBarButtonItems(rightBarButtonItems, animated: true)
        }
    }
}
