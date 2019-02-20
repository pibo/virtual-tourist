//
//  FlickrRequest.swift
//  Virtual Tourist
//
//  Created by Felipe Ribeiro on 12/02/19.
//  Copyright © 2019 Felipe Ribeiro. All rights reserved.
//

import Foundation

extension Flickr {
    
    class Request {
        
        // MARK: - Constants
        
        static let scheme = "https"
        static let host = "api.flickr.com"
        static let path = "/services/rest"
        static let parameters: [String: String] = [
            "key": "api_key",
            "noJSONCallback": "nojsoncallback",
            "safeSearch": "safe_search",
            "boundingBox": "bbox",
            "perPage": "per_page",
        ]
        
        // MARK: - Parameters
        
        let key = "1fcc74bb6d17b437ad56aba06dcabd9a"
        var format = "json"
        var noJSONCallback = "1"
        var safeSearch = "1"
        var extras = "url_z"
        var page = "1"
        var perPage = "30"
        
        // MARK: - Computed Properties
        
        var url: URL {
            var components = URLComponents()
            components.scheme = Request.scheme
            components.host = Request.host
            components.path = Request.path
            components.queryItems = []
            
            let asQueryItem: (Mirror.Child) -> URLQueryItem = {
                return URLQueryItem(name: self.param(for: $0.label!), value: $0.value as? String)
            }
            
            // Get all the public properties as parameters and also add parameters
            // from the parent (for subclasses of Request)
            let mirror = Mirror(reflecting: self)
            
            if let parentMirror = mirror.superclassMirror {
                components.queryItems!.append(contentsOf: parentMirror.children.map(asQueryItem))
            }
            
            components.queryItems!.append(contentsOf: mirror.children.map(asQueryItem))
            
            return components.url!
        }
        
        // MARK: - Helper Methods
        
        private func param(for key: String) -> String {
            return Request.parameters[key] ?? key
        }
    }
}
