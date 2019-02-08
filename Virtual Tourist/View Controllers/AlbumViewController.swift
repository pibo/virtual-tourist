//
//  AlbumViewController.swift
//  Virtual Tourist
//
//  Created by Felipe Ribeiro on 07/02/19.
//  Copyright © 2019 Felipe Ribeiro. All rights reserved.
//

import UIKit
import MapKit

class AlbumViewController: UIViewController {

    // MARK: - Properties
    
    let distanceSpan: CLLocationDistance = 20000.0
    let photoCollectionSpacing: CGFloat = 4.0
    var location: Location!
    
    // MARK: - Outlets
    
    @IBOutlet var photoCollection: UICollectionView!
}
