//
//  FlickrResponse.swift
//  Virtual Tourist
//
//  Created by Felipe Ribeiro on 12/02/19.
//  Copyright © 2019 Felipe Ribeiro. All rights reserved.
//

import Foundation

struct FlickrResponse: Decodable {
    
    // MARK: - Properties
    
    let page: Int
    let pages: Int
    let perPage: Int
    let total: Int
    let photos: [FlickrPhoto]
    
    // MARK: - Initializer
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let photos = try container.nestedContainer(keyedBy: CodingKeys.self, forKey: .photos)
        
        page = try photos.decode(Int.self, forKey: .page)
        pages = try photos.decode(Int.self, forKey: .pages)
        perPage = try photos.decode(Int.self, forKey: .perPage)
        total = Int(try photos.decode(String.self, forKey: .total))!
        self.photos = try photos.decode([FlickrPhoto].self, forKey: .photo)
    }
    
    // MARK: - Coding Keys
    
    enum CodingKeys: String, CodingKey {
        case photos
        case page
        case pages
        case perPage = "perpage"
        case total
        case photo
    }
}
