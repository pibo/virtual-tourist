//
//  DetailCalloutView.swift
//  Virtual Tourist
//
//  Created by Felipe Ribeiro on 05/02/19.
//  Copyright © 2019 Felipe Ribeiro. All rights reserved.
//

import UIKit

class DetailCalloutView: UIStackView {

    // MARK: - Outlets
    
    @IBOutlet var subtitleLabel: UILabel!
    @IBOutlet var photoCount: UIStackView!
    @IBOutlet var photoCountLabel: UILabel!
    @IBOutlet var deleteButton: UIButton!
    @IBOutlet var albumButton: UIButton!
    
    // MARK: - Helper Methods
    
    func setPhotoCount(_ count: Int) {
        photoCount.isHidden = count < 1
        var text = "\(count) "
        text += count == 1 ? "photo" : "photos"
        photoCountLabel.text = "\(text) in this album"
    }
}
