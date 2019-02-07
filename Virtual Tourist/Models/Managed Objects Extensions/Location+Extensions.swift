//
//  Location+Extensions.swift
//  Virtual Tourist
//
//  Created by Felipe Ribeiro on 01/02/19.
//  Copyright © 2019 Felipe Ribeiro. All rights reserved.
//

import Foundation

extension Location {
    public override func awakeFromInsert() {
        super.awakeFromInsert()
        createdAt = Date()
    }
}

func ==<T: Location>(lhs: T, rhs: T) -> Bool {
    return lhs.objectID == rhs.objectID
}
