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
    @IBOutlet var noPhotosAvailableLabel: UILabel!
    @IBOutlet var distanceFromMapToLabel: NSLayoutConstraint!
    @IBOutlet var distanceFromMapToPhotos: NSLayoutConstraint!

    // MARK: - Helper Methods

    func hasPhotos(_ has: Bool) {
        noPhotosAvailableLabel.isHidden = has
        distanceFromMapToPhotos.isActive = has
        distanceFromMapToLabel.isActive = !has
    }
}
