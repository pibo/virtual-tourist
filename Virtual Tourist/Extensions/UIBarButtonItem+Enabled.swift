//
//  UIBarButtonItem+Enabled.swift
//  Virtual Tourist
//
//  Created by Felipe Ribeiro on 18/02/19.
//  Copyright © 2019 Felipe Ribeiro. All rights reserved.
//

import UIKit

extension UIBarButtonItem {
    
    func enabled(_ enabled: Bool) {
        isEnabled = enabled
        tintColor = tintColor?.withAlphaComponent(enabled ? 1.0 : 0.25)
    }
}
