//
//  Flickr.swift
//  Virtual Tourist
//
//  Created by Felipe Ribeiro on 12/02/19.
//  Copyright © 2019 Felipe Ribeiro. All rights reserved.
//

import Foundation

class Flickr {
    
    // MARK: - Helper Methods
    
    class func get(_ url: URL, completion: @escaping (Data?, Error?) -> Void) -> URLSessionDataTask {
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data else {
                completion(nil, error)
                return
            }
            
            if let statusCode = (response as? HTTPURLResponse)?.statusCode, !(200...299).contains(statusCode) {
                completion(nil, error)
                return
            }
            
            completion(data, nil)
        }
        
        task.resume()
        
        return task
    }
    
    // MARK: - External API
    
    class func search(latitude: Double, longitude: Double, page: Int = 1, completion: @escaping (FlickrResponse?, Error?) -> Void) {
        let request = LocationSearch(latitude: latitude, longitude: longitude)
        request.page = String(page)
        
        let _ = get(request.url) { data, error in
            guard error == nil else {
                completion(nil, error)
                return
            }
            
            let decoded = try! JSONDecoder().decode(FlickrResponse.self, from: data!)
            
            DispatchQueue.main.async {
                completion(decoded, nil)
            }
        }
    }
}
