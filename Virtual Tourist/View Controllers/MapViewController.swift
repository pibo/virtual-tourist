//
//  MapViewController.swift
//  Virtual Tourist
//
//  Created by Felipe Ribeiro on 31/01/19.
//  Copyright © 2019 Felipe Ribeiro. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation
import CoreData

class MapViewController: UIViewController {
    
    // MARK: - Properties
    
    let mapLongPressMinimumDuration: TimeInterval = 0.8
    let onboardingTimeout: TimeInterval = 1.5
    var fetchedResultsController: NSFetchedResultsController<Location>!
    lazy var locationManager: CLLocationManager = CLLocationManager()

    // MARK: - Outlets
    
    @IBOutlet var mapView: MKMapView!
    
    // MARK: - Life Cycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Define delegates.
        mapView.delegate = self
        
        // Subscribe to app events to save the map's region.
        NotificationCenter.default.addObserver(self, selector: #selector(persistMapRegion), name: UIApplication.willTerminateNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(persistMapRegion), name: UIApplication.didEnterBackgroundNotification, object: nil)
        
        setupUserTrackingButton()
        
        restoreMapRegion()
        
        // Show onboarding if the app is being launched for the first time.
        if let app = (UIApplication.shared.delegate as? AppDelegate), app.firstLaunch {
            DispatchQueue.main.asyncAfter(deadline: .now() + onboardingTimeout) {
                self.showOnboarding()
            }
        }
        
        subscribeMapToLongPress()
        
        setupFetchedResultsController()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        persistMapRegion()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: UIApplication.willTerminateNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIApplication.didEnterBackgroundNotification, object: nil)
    }
    
    // MARK: - Helper Methods
    
    func setupUserTrackingButton() {
        let buttomItem = MKUserTrackingBarButtonItem(mapView: mapView)
        buttomItem.customView?.tintColor = UIColor(named: "Primary Yellow")!
        navigationItem.rightBarButtonItem = buttomItem
    }
    
    func setupFetchedResultsController() {
        let request: NSFetchRequest<Location> = Location.fetchRequest()
        let byDate = NSSortDescriptor(key: "createdAt", ascending: false)
        
        request.sortDescriptors = [byDate]
        
        fetchedResultsController = NSFetchedResultsController(
            fetchRequest: request,
            managedObjectContext: DataController.shared.viewContext,
            sectionNameKeyPath: nil,
            cacheName: nil
        )
        
        fetchedResultsController.delegate = self
        
        do {
            try fetchedResultsController.performFetch()
            createAnnotations()
        } catch {
            fatalError("The saved locations couldn't be loaded: \(error.localizedDescription)")
        }
    }
    
    @objc func persistMapRegion() {
        let centerCoordinate = mapView.region.center
        let coordinateSpan = mapView.region.span
        
        let regionDictionary: [String: CLLocationDegrees] = [
            "latitude": centerCoordinate.latitude,
            "longitude": centerCoordinate.longitude,
            "latitudeDelta": coordinateSpan.latitudeDelta,
            "longitudeDelta": coordinateSpan.longitudeDelta,
        ]
        
        UserDefaults.standard.set(regionDictionary, forKey: UserDefaultsKeys.mapViewLastRegion)
    }
    
    func restoreMapRegion() {
        // Prioritize if the user has persisted a tracking mode.
        if let userTrackingMode = UserDefaults.standard.value(forKey: UserDefaultsKeys.userTrackingMode) as? Int {
            let mode = MKUserTrackingMode(rawValue: userTrackingMode)!
            mapView.setUserTrackingMode(mode, animated: false)
        } else if let persistedRegion = UserDefaults.standard.dictionary(forKey: UserDefaultsKeys.mapViewLastRegion) as? [String: CLLocationDegrees] {
            let center = CLLocationCoordinate2DMake(persistedRegion["latitude"]!, persistedRegion["longitude"]!)
            let span = MKCoordinateSpan(latitudeDelta: persistedRegion["latitudeDelta"]!, longitudeDelta: persistedRegion["longitudeDelta"]!)
            let region = MKCoordinateRegion(center: center, span: span)
            
            mapView.setRegion(region, animated: false)
        }
    }
    
    func showOnboarding() {
        let onboarding = storyboard!.instantiateViewController(withIdentifier: "OnboardingScene") as! OnboardingViewController
        onboarding.providesPresentationContextTransitionStyle = true
        onboarding.definesPresentationContext = true
        onboarding.modalPresentationStyle = .overCurrentContext
        onboarding.modalTransitionStyle = .crossDissolve
        
        present(onboarding, animated: true, completion: nil)
    }
    
    func subscribeMapToLongPress() {
        let gestureRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(newLocation))
        gestureRecognizer.minimumPressDuration = mapLongPressMinimumDuration
        mapView.addGestureRecognizer(gestureRecognizer)
    }
    
    @objc func newLocation(gestureRecognizer: UIGestureRecognizer) {
        guard gestureRecognizer.state == .began else { return }
        
        let touchPoint = gestureRecognizer.location(in: mapView)
        let coordinate = mapView.convert(touchPoint, toCoordinateFrom: mapView)
        let location = CLLocation(latitude: coordinate.latitude, longitude: coordinate.longitude)
        
        CLGeocoder().reverseGeocodeLocation(location) { placemarks, error in
            guard error == nil else {
                print("Reverse geocoder failed with error: \(error!.localizedDescription)")
                return
            }
        
            let location = Location(context: DataController.shared.viewContext)
            location.latitude = coordinate.latitude
            location.longitude = coordinate.longitude
            
            if let placemarks = placemarks, placemarks.count > 0 {
                let placemark = placemarks.first!
                location.locality = placemark.locality
                location.subLocality = placemark.subLocality
            } else {
                location.locality = "Unknown Location"
            }
            
            try? DataController.shared.viewContext.save()
        }
    }
    
    func createAnnotations() {
        let locations: [Location]? = fetchedResultsController.fetchedObjects
        
        if let locations = locations {
            let annotations = locations.map(LocationMarker.init)
            mapView.addAnnotations(annotations)
        }
    }
}
