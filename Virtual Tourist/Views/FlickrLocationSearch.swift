//
//  FlickrLocationSearch.swift
//  Virtual Tourist
//
//  Created by Felipe Ribeiro on 12/02/19.
//  Copyright © 2019 Felipe Ribeiro. All rights reserved.
//

import Foundation
import CoreLocation

extension Flickr {

    class LocationSearch: Request {
        
        // MARK: - Constants
        
        static let boundingBoxOffset = (width: 1.0, height: 1.0)
        static let latitudeRange = (min: -90.0, max: 90.0)
        static let longitudeRange = (min: -180.0, max: 180.0)
        
        let method = "flickr.photos.search"
        let boundingBox: String
        
        // MARK: - Initializer
        
        init(latitude: CLLocationDegrees, longitude: CLLocationDegrees) {
            let minimumLongitude = max(longitude - LocationSearch.boundingBoxOffset.width, LocationSearch.longitudeRange.min)
            let minimumLatitude = max(latitude - LocationSearch.boundingBoxOffset.height, LocationSearch.latitudeRange.min)
            let maximumLongitude = min(longitude + LocationSearch.boundingBoxOffset.width, LocationSearch.longitudeRange.max)
            let maximumLatitude = min(latitude + LocationSearch.boundingBoxOffset.height, LocationSearch.latitudeRange.max)
            
            boundingBox = "\(minimumLongitude),\(minimumLatitude),\(maximumLongitude),\(maximumLatitude)"
            
            super.init()
        }
    }
}
