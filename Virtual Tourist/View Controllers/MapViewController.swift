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

class MapViewController: UIViewController {
    
    // MARK: - Properties
    
    let onboardingTimeout: TimeInterval = 1.5
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
        
        setupUserTrackingButton()
        restoreMapRegion()
        
        if let app = (UIApplication.shared.delegate as? AppDelegate), app.firstLaunch {
            DispatchQueue.main.asyncAfter(deadline: .now() + onboardingTimeout) {
                self.showOnboarding()
            }
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        persistMapRegion()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: UIApplication.willTerminateNotification, object: nil)
    }
    
    // MARK: - Helper Methods
    
    func setupUserTrackingButton() {
        navigationItem.rightBarButtonItem = MKUserTrackingBarButtonItem(mapView: mapView)
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
}
