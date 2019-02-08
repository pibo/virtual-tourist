//
//  PhotoLocationHeaderView.swift
//  Virtual Tourist
//
//  Created by Felipe Ribeiro on 08/02/19.
//  Copyright © 2019 Felipe Ribeiro. All rights reserved.
//

import UIKit
import MapKit

class PhotoLocationHeaderView: UICollectionReusableView {
    
    // MARK: - Outlets
    
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var subtitleLabel: UILabel!
    @IBOutlet var mapView: MKMapView!
}
