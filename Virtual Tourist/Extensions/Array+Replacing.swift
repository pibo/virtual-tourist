//
//  Array+Replacing.swift
//  Virtual Tourist
//
//  Created by Felipe Ribeiro on 16/02/19.
//  Copyright © 2019 Felipe Ribeiro. All rights reserved.
//

import Foundation

extension Array where Element: Equatable {
    
    func replacing(_ item: Element, with replacement: Element) -> Array {
        var newArray = self
        var i = newArray.firstIndex(of: item)
        
        while i != nil {
            newArray[i!] = replacement
            i = newArray.firstIndex(of: item)
        }
        
        return newArray
    }
}
