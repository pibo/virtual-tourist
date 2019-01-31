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
    
    lazy var locationManager: CLLocationManager = CLLocationManager()

    // MARK: - Outlets
    
    @IBOutlet var mapView: MKMapView!
    
    // MARK: - Life Cycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Define delegates.
        mapView.delegate = self
        
        setupUserTrackingButton()
        restoreMapRegion()
    }
    
    // MARK: - Helper Methods
    
    func setupUserTrackingButton() {
        navigationItem.rightBarButtonItem = MKUserTrackingBarButtonItem(mapView: mapView)
    }
    
    func restoreMapRegion() {
        // Check if the user has persisted a tracking mode.
        if let userTrackingMode = UserDefaults.standard.value(forKey: UserDefaultsKeys.userTrackingMode) as? Int {
            let mode = MKUserTrackingMode(rawValue: userTrackingMode)!
            mapView.setUserTrackingMode(mode, animated: false)
        } else {
            
        }
    }
}
