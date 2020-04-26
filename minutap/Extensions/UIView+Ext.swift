//
//  UIView+Ext.swift
//  minutap-game
//
//  Created by Filip Brej on 3/19/20.
//  Copyright © 2020 Filip Brej. All rights reserved.
//

import UIKit

extension UIView {
    
    
    // Add multiple subviews in one line
    func addSubviews(_ views: UIView...) {
        for view in views {
            addSubview(view)
        }
    }
}
