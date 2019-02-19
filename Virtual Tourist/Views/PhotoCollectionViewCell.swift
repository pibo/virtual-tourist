//
//  PhotoCollectionViewCell.swift
//  Virtual Tourist
//
//  Created by Felipe Ribeiro on 07/02/19.
//  Copyright © 2019 Felipe Ribeiro. All rights reserved.
//

import UIKit

class PhotoCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Properties
    
    var photo: Photo!
    
    override var isSelected: Bool {
        didSet {
            photoImageView.alpha = isSelected ? 0.5 : 1.0
            tickImageView.isHidden = !isSelected
        }
    }
    
    // MARK: - Outlets
    
    @IBOutlet var photoImageView: UIImageView!
    @IBOutlet var tickImageView: UIImageView!
    @IBOutlet var placeholderImage: UIView!
}
