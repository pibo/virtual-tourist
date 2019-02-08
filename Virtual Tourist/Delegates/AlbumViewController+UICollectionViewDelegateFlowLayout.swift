//
//  AlbumViewController+UICollectionViewDelegateFlowLayout.swift
//  Virtual Tourist
//
//  Created by Felipe Ribeiro on 07/02/19.
//  Copyright © 2019 Felipe Ribeiro. All rights reserved.
//

import UIKit
import MapKit

extension AlbumViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return photoCollectionSpacing
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return photoCollectionSpacing
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let collectionWidth: CGFloat = collectionView.frame.size.width
        
        let width = UIDevice.current.orientation.isPortrait
            ? (collectionWidth - 2 * photoCollectionSpacing) / 3.0
            : (collectionWidth - 4 * photoCollectionSpacing) / 5.0
        
        return CGSize(width: width, height: width)
    }
}

