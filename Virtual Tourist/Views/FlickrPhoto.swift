//
//  FlickrPhoto.swift
//  Virtual Tourist
//
//  Created by Felipe Ribeiro on 12/02/19.
//  Copyright © 2019 Felipe Ribeiro. All rights reserved.
//

import Foundation

struct FlickrPhoto: Decodable {
    
    // MARK: - Properties
    
    let id: Int
    let title: String?
    let url: URL?
    let width: Int
    let height: Int
    
    // MARK: - Initializer
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        id = Int(try container.decode(String.self, forKey: .id))!
        title = try container.decodeIfPresent(String.self, forKey: .title)
        url = URL(string: try container.decode(String.self, forKey: .url))
        
        do {
            width = try container.decode(Int.self, forKey: .width)
        } catch {
            width = Int(try container.decode(String.self, forKey: .width))!
        }
        
        do {
            height = try container.decode(Int.self, forKey: .height)
        } catch {
            height = Int(try container.decode(String.self, forKey: .height))!
        }
    }
    
    // MARK: - Coding Keys
    
    enum CodingKeys: String, CodingKey {
        case id, title
        case url = "url_z"
        case width = "width_z"
        case height = "height_z"
    }
}
