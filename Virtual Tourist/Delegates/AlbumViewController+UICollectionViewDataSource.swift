//
//  AlbumViewController+MKMapViewDelegate.swift
//  Virtual Tourist
//
//  Created by Felipe Ribeiro on 07/02/19.
//  Copyright © 2019 Felipe Ribeiro. All rights reserved.
//

import MapKit

extension AlbumViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoCollectionViewCell", for: indexPath) as! PhotoCollectionViewCell
        let photo = fetchedResultsController.object(at: indexPath)
        
        if let image = photo.image {
            cell.photoImageView.image = UIImage(data: image)
            cell.photoImageView.isHidden = false
            cell.placeholderImage.isHidden = true
        } else {
            cell.photoImageView.isHidden = true
            cell.placeholderImage.isHidden = false
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            let view = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "PhotoLocationHeaderView", for: indexPath) as? PhotoLocationHeaderView
            guard view != nil else { fatalError("Invalid header view type") }
            return configure(header: view!)
        default: assert(false, "Invalid element type")
        }
    }
    
    // Determine header size depending if there are photos or not.
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        let height: CGFloat = photos.count > 0 ? 400.0 : 512.0
        return CGSize(width: collectionView.bounds.width, height: height)
    }
    
    func configure(header view: PhotoLocationHeaderView) -> PhotoLocationHeaderView {
        view.titleLabel.text = location.title
        view.subtitleLabel.text = location.country
        view.mapView.delegate = self
        view.hasPhotos(photos.count > 0)
        
        let _ = configure(map: view.mapView)
        
        return view
    }
    
    func configure(map view: MKMapView) -> MKMapView {
        let annotation = LocationAnnotation(location)
        view.addAnnotation(annotation)
        
        // Set the map region for the annotation to be visible.
        let center = CLLocationCoordinate2DMake(location.latitude, location.longitude)
        let region = MKCoordinateRegion(center: center, latitudinalMeters: distanceSpan, longitudinalMeters: distanceSpan)
        
        view.setRegion(region, animated: false)
        
        return view
    }
}
