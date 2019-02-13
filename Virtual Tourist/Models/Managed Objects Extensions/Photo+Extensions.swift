//
//  Photo+Extensions.swift
//  Virtual Tourist
//
//  Created by Felipe Ribeiro on 13/02/19.
//  Copyright © 2019 Felipe Ribeiro. All rights reserved.
//

import Foundation
import CoreData

extension Photo {
    
    // MARK: - Life Cycle Methods
    
    public override func awakeFromInsert() {
        super.awakeFromInsert()
        createdAt = Date()
    }
    
    // MARK: - Convenience Initializer
    
    convenience init(fromFlickr flickr: FlickrPhoto, location: Location, context: NSManagedObjectContext) {
        self.init(context: context)
        
        id = Int64(flickr.id)
        title = flickr.title
        url = flickr.url
        width = Int16(flickr.width)
        height = Int16(flickr.height)
        self.location = location
    }
}

func ==<T: Photo>(lhs: T, rhs: T) -> Bool {
    return lhs.objectID == rhs.objectID
}
